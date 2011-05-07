//
//  StrawEggBlock.m
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "StrawEggBlock.h"
#import "CushionEggBlock.h"
#import "EggNail.h"

@implementation StrawEggBlock

-(id) initWithRect:(CGRect)blockRect
{
    if((self=[super initWithRect:blockRect]))
    {
        blockType = @"straw";
        density = 0.5;
        friction = 1;
        impulseLimit = 20;
        totalImpulse = 0;
        baseImpulse = -1;
    }
    return self;
}

-(void) loadGraphics:(CGRect)blockRect
{
    mySprite = [CCSprite spriteWithFile:@"woodblocktexture.png"];
    mySprite.position = ccp(blockRect.origin.x, blockRect.origin.y);
    width = blockRect.size.width;
    height = blockRect.size.height;
    mySprite.scaleX = width/mySprite.contentSize.width;
    mySprite.scaleY = height/mySprite.contentSize.height;
    
    [self addChild:mySprite];
    desiredZ = 0;
}

-(BOOL) shouldRemoveFromPhysics
{
    return totalImpulse >= impulseLimit;
    
    
}

//for removing this object from physics
-(void) removeFromPhysicsWorld:(b2World*)world
{
    //need to make sure we didn't just destroy a joint as well.
    for(b2JointEdge *j = body->GetJointList(); j; j=j->next)
    {
        b2Joint *joint = j->joint;
        if(joint->GetUserData() != NULL)
        {
            id myID = (id)joint->GetUserData();
            if( [[myID class] isSubclassOfClass:[EggNail class]] || [myID class] == [EggNail class])
            {
                EggNail* myNail = (EggNail*)(myID);
                [myNail removeFromPhysicsWorld:world];
            }
        }
    }
    
    
    //simply destroy our body
    world->DestroyBody(body);
     
}

-(void)updatePhysics
{
    //first update our physics the old fashioned way
    [super updatePhysics];
    //now apply our impulses.
    float max_impulse = 0;
    for (b2ContactEdge* ce = body->GetContactList(); ce; ce = ce->next)
    {

        //check to see if we're dealing with a cushion first. If so, we don't apply any impulse. 
        //this code is a little sloppy, but I think it's acceptable. 
        if(ce->other->GetUserData() != NULL && [(id)(ce->other->GetUserData()) class] == [CushionEggBlock class])
        {
            continue;
        }
        
        
        b2Contact* c = ce->contact;
        
        // process c
        b2Manifold* myManifold = c->GetManifold();
        for(int i = 0; i < b2_maxManifoldPoints; i++)
        {
            b2ManifoldPoint mPoint = myManifold->points[i];
            if(mPoint.normalImpulse > max_impulse)
                max_impulse = mPoint.normalImpulse;
        }
        
    }
    //need to wait until the transient impulse disapears before allowing the block to be broken.
    if(baseImpulse == -1 || baseImpulse > 9)
    {
        NSLog(@"starting Impulse: %f", max_impulse);
        baseImpulse = max_impulse;
    }
    else if(fabsf(max_impulse) > 1)
    {
        totalImpulse += max_impulse;
    }

}

-(id)copyWithZone:(NSZone*)zone
{
    StrawEggBlock *clone = [[StrawEggBlock allocWithZone:zone] initWithRect:CGRectMake(self.position.x, self.position.y, self.width, self.height)];
    return clone;
}

@end
