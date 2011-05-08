//
//  CloudEggBlock.m
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "CloudEggBlock.h"
#import "EggNail.h"


@implementation CloudEggBlock

-(id) initWithRect:(CGRect)blockRect
{
    if((self = [super initWithRect:blockRect]))
    {
        blockType = @"cloud";
        density = 1.5;
    }
    return self;
}

-(void) loadGraphics:(CGRect)blockRect
{
    mySprite = [CCSprite spriteWithFile:@"cloud2.png"];
    mySprite.position = ccp(blockRect.origin.x, blockRect.origin.y);
    width = blockRect.size.width;
    height = blockRect.size.height;
    mySprite.scaleX = width/mySprite.contentSize.width;
    mySprite.scaleY = height/mySprite.contentSize.height;
    
    [self addChild:mySprite];
    desiredZ = 0;
}


-(void) removeFromGame:(HelloWorldLayer *)mainLayer andPhysicsWorld:(b2World*)world
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
    
    
    [mainLayer removeChild:self cleanup:YES];
}

-(id)copyWithZone:(NSZone*)zone
{
    CloudEggBlock *clone = [[CloudEggBlock allocWithZone:zone] initWithRect:CGRectMake(self.position.x, self.position.y, self.width, self.height)];
    return clone;
}


@end
