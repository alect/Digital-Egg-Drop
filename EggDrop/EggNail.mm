//
//  EggNail.m
//  EggDrop
//
//  Created by Alec Thomson on 4/24/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggNail.h"
#import <math.h>

@implementation EggNail

-(id) init
{
    if((self=[super init]))
    {
        strapMiddle = [[CCSprite spriteWithFile:@"woodblock.png"] retain];
        strapMiddle.scaleY = 5/strapMiddle.contentSize.height;
        strapEnd = [[CCSprite spriteWithFile:@"concrete_block.png"] retain];
        strapEnd.scale = 10/strapEnd.contentSize.width;
        
        firstAnchor = ccp(0, 0);
        secondAnchor = ccp(30, 0);
        desiredZ = 1;
        
    }
    return self;
}

-(void) setPosition:(CGPoint)position
{
    CGPoint relativeAnchor = ccp(secondAnchor.x-firstAnchor.x, secondAnchor.y-firstAnchor.y);
    firstAnchor = position;
    secondAnchor = ccp(firstAnchor.x+relativeAnchor.x, firstAnchor.y+relativeAnchor.y);
}

//code for actually drawing the CCNode
-(void) visit
{
    [super visit];
    //we're going to have to draw the middle first by scaling and rotating it appropriately    
    double rotationRad = atan2(secondAnchor.x-firstAnchor.x, secondAnchor.y-firstAnchor.y) + M_PI_2;
    double degrees = rotationRad*180.0/M_PI;
    strapMiddle.rotation = degrees;
    double dis = sqrt(pow(secondAnchor.x-firstAnchor.x, 2) + pow(secondAnchor.y-firstAnchor.y, 2));
    strapMiddle.scaleX = dis/strapMiddle.contentSize.width;
    strapMiddle.position = ccp(secondAnchor.x+dis/2*cos(rotationRad), secondAnchor.y-dis/2*sin(rotationRad));
    [strapMiddle visit];
    //whew, works now.
    
    strapEnd.position = ccp(firstAnchor.x, firstAnchor.y);
    [strapEnd visit];
    strapEnd.position = ccp(secondAnchor.x, secondAnchor.y);
    [strapEnd visit];
}

-(void) beginAddToWorld:(CGPoint)location
{
    firstAnchor = ccp(location.x, location.y);
    secondAnchor = ccp(location.x, location.y);
}

-(void) updateAddToWorld:(CGPoint)location
{
    secondAnchor = ccp(location.x, location.y);
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

    
    b2WeldJointDef jointDef;
    
    localA = bodyAnchor1->GetLocalPoint(anchor1);
    localB = bodyAnchor2->GetLocalPoint(anchor2);
    
    jointDef.Initialize(bodyAnchor1, bodyAnchor2, anchor1);
    jointDef.userData = self;
    
    strapJoint = world->CreateJoint(&jointDef);
    return YES;
    
}

-(void) updatePhysics
{
    b2Vec2 globalA = strapJoint->GetBodyA()->GetWorldPoint(localA);
    b2Vec2 globalB = strapJoint->GetBodyB()->GetWorldPoint(localB);
    
    firstAnchor = ccp(globalA.x*PTM_RATIO, globalA.y*PTM_RATIO);
    secondAnchor = ccp(globalB.x*PTM_RATIO, globalB.y*PTM_RATIO);
}


-(void) dealloc
{
    [strapMiddle release];
    [strapEnd release];
    [super dealloc];
}

@end