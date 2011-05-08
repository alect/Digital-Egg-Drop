//
//  EggNail.m
//  EggDrop
//
//  Created by Alec Thomson on 4/24/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggNail.h"
#import "Egg.h"
#import <math.h>

@implementation EggNail

@synthesize isBroken;

-(id) initWithAnchor1:(CGPoint)anchor1 andAnchor2:(CGPoint)anchor2
{
    if((self=[super init]))
    {
        strapMiddle = [[CCSprite spriteWithFile:@"woodblock.png"] retain];
        strapMiddle.scaleY = 5/strapMiddle.contentSize.height;
        strapEnd = [[CCSprite spriteWithFile:@"concrete_block.png"] retain];
        strapEnd.scale = 10/strapEnd.contentSize.width;
        
        firstAnchor = ccp(anchor1.x, anchor1.y);
        secondAnchor = ccp(anchor2.x, anchor2.y);
        desiredZ = 1;
        isBroken = NO;
    }
    return self;
}

-(id) init
{
    return [self initWithAnchor1:ccp(0, 0) andAnchor2:ccp(30, 0)];
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

-(void) resetToPosition:(CGSize)size atPoint:(CGPoint)location
{
    firstAnchor = location;
    secondAnchor = ccp(firstAnchor.x+30, firstAnchor.y);
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

    //check quickly to see if we just nailed an egg
    if([(id)bodyAnchor1->GetUserData() class] == [Egg class] )
    {
        Egg* myEgg = (Egg*)bodyAnchor1->GetUserData();
        myEgg.broken = YES;
    }
    if([(id)bodyAnchor2->GetUserData() class] == [Egg class] )
    {
        Egg* myEgg = (Egg*)bodyAnchor2->GetUserData();
        myEgg.broken = YES;
    }
    
    
    
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


-(BOOL) shouldRemoveFromPhysics
{
    return isBroken;
}

-(void) removeFromPhysicsWorld:(b2World*)world
{
    //don't actually need to do anything here. the removal of bodies should take care of this. 
    //just need to remove ourselves from the image
    [self removeFromParentAndCleanup:YES];
}



-(void) dealloc
{
    [strapMiddle release];
    [strapEnd release];
    [super dealloc];
}

-(id) copyWithZone:(NSZone*)zone
{
    EggNail * clone = [[EggNail allocWithZone:zone] init];
    return clone;
}


@end
