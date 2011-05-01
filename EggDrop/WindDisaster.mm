//
//  WindDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 4/30/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "WindDisaster.h"
#import "HelloWorldLayer.h"

@implementation WindDisaster

-(id) initWithDelay:(float)myDelay andStrength:(float)strength andDuration:(float)duration
{
    if((self= [super init]))
    {
        self->delay = myDelay;
        windStrength = strength;
        windDuration = duration;
    }
    return self;
}

-(void) addDisasterToGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    mainLayer.windy = YES;
    mainLayer.windStrength = windStrength;
}

-(void) removeDisasterFromGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    mainLayer.windy = NO;
}

-(BOOL) isDisasterActive:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    return mainLayer.timeSinceLastDisaster < windDuration;
}

@end
