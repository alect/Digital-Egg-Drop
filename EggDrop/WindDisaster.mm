//
//  WindDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 4/30/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "WindDisaster.h"
#import "HelloWorldLayer.h"
#import "ResourceManager.h"

@implementation WindDisaster

-(id) initWithDelay:(float)myDelay andStrength:(float)strength andDuration:(float)duration
{
    if((self= [super init]))
    {
        self->delay = myDelay;
        windStrength = strength;
        windDuration = duration;
        disasterName = @"Wind";
    }
    return self;
}

-(void) addDisasterToGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    mainLayer.windy = YES;
    mainLayer.windStrength = windStrength;
    
    mySoundID = [[SimpleAudioEngine sharedEngine] playEffect:@"wind.caf" pitch:1.0f pan:0.0 gain:1.0f loop:YES];
}

-(void) removeDisasterFromGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    mainLayer.windy = NO;
    [[SimpleAudioEngine sharedEngine] stopEffect:mySoundID];
    
}

-(BOOL) isDisasterActive:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    return mainLayer.timeSinceLastDisaster < windDuration;
}

-(id) copyWithZone:(NSZone*)zone
{
    WindDisaster * clone = [[WindDisaster allocWithZone:zone] initWithDelay:delay andStrength:windStrength andDuration:windDuration];
    return clone;
}

-(NSString*) disasterDescription:(HelloWorldLayer *)mainLayer
{
    return [NSString stringWithFormat:@"Wind strength= %d Newtons ends in: %d", (int)windStrength, (int)roundf(windDuration-mainLayer.timeSinceLastDisaster)]; 
}

-(CCSprite*) disasterIcon:(HelloWorldLayer*)mainLayer
{
    return [[CCSprite spriteWithFile:@"cloud-icon.png"] autorelease];
}


@end
