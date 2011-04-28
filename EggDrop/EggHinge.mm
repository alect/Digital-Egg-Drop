//
//  EggHinge.m
//  EggDrop
//
//  Created by Alec Thomson on 4/28/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggHinge.h"
#import <math.h>

@implementation EggHinge

-(id) init
{
    if((self=[super init]))
    {
        //release the images used by our parent because we need to use different images
        //HACK: this is kind of sloppy code, but it allows a lot of reuse of the EggNail code. 
        [strapMiddle release];
        strapMiddle = [[CCSprite spriteWithFile:@"concrete_block.png"] retain];
        strapMiddle.scaleY = 5/strapMiddle.contentSize.height;
        [strapEnd release];
        strapEnd = [[CCSprite spriteWithFile:@"woodblock.png"] retain];
        strapEnd.scale = 10/strapEnd.contentSize.width;
        
        firstAnchor = ccp(0, 0);
        secondAnchor = ccp(30, 0);
        desiredZ = 1;
    }
    return self;
}


-(BOOL) addToPhysicsWorld:(b2World*)world
{
    //need to first make sure the two endpoints are intersecting
    //some physical object in the world. 
    b2Body* bodyAnchor1;
    b2Vec2 anchor1(firstAnchor.x/PTM_RATIO, firstAnchor.y/PTM_RATIO);
    BOOL isAnchor1 = NO; 
    b2Body* bodyAnchor2;
    b2Vec2 anchor2(secondAnchor.x/PTM_RATIO, secondAnchor.y/PTM_RATIO);
    BOOL isAnchor2 = NO;
    for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
        for(b2Fixture* f = b->GetFixtureList(); f; f = f->GetNext())
        {
            if(f->TestPoint(anchor1))
            {
                bodyAnchor1 = b;
                isAnchor1 = YES;
            }
            if(bodyAnchor1 != b && f->TestPoint(anchor2))
            {
                bodyAnchor2 = b;
                isAnchor2 = YES;
            }
        }
    }
    if(!isAnchor1 || !isAnchor2)
        return NO;
    
    //need to find the mid-point between the two anchors
    b2Vec2 relAnchor = anchor2-anchor1;
    relAnchor*=0.5f;
    b2Vec2 anchor = anchor1+relAnchor;
    
    b2RevoluteJointDef jointDef;
    jointDef.Initialize(bodyAnchor1, bodyAnchor2, anchor);
    
    jointDef.userData = self;
    //jointDef.collideConnected = true;

    strapJoint = world->CreateJoint(&jointDef);
    return YES;
    
}



@end
