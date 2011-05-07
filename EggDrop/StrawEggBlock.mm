//
//  StrawEggBlock.m
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "StrawEggBlock.h"


@implementation StrawEggBlock

-(id) initWithRect:(CGRect)blockRect
{
    if((self=[super initWithRect:blockRect]))
    {
        blockType = @"straw";
        impulseLimit = 20;
        totalImpulse = 0;
        baseImpulse = -1;
    }
    return self;
}

-(void) loadGraphics:(CGRect)blockRect
{
    NSLog(@"LOADING GRAPHICS");
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
        //first make sure we're actually touching something that's not a cushion
        //TODO: cushion stuff in here. 
        
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
