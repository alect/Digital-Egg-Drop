//
//  CloudBlockDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "CloudBlockDisaster.h"

@implementation CloudBlockDisaster


-(id) initWithDelay:(float)_delay andDuration:(float)_duration
{
    if((self = [super init]))
    {
        disasterName = @"Cloud";
        delay = _delay;
        duration = _duration;
    }
    return self;
}

-(void) addDisasterToGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    //need to remove all of our clouds at the start of the disaster
    for(CloudEggBlock * cBlock in mainLayer.myClouds)
    {
        [cBlock removeFromGame:mainLayer andPhysicsWorld:world];
    }
}

-(BOOL) isDisasterActive:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    return mainLayer.timeSinceLastDisaster < duration;
}

-(void) removeDisasterFromGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    //don't really need to do anything here.
}


-(id) copyWithZone:(NSZone*)zone
{
    CloudBlockDisaster* clone = [[CloudBlockDisaster allocWithZone:zone] initWithDelay:delay andDuration:duration];
    return clone;
}

-(NSString*) disasterDescription:(HelloWorldLayer *)mainLayer
{
    return [NSString stringWithFormat:@"Clouds Disappear! Survive for: %d", (int)roundf(duration-mainLayer.timeSinceLastDisaster)];
}

-(void) dealloc
{
    [super dealloc];
}

@end
