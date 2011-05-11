//
//  QuakeDisaster.h
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggDisaster.h"
#import "SimpleAudioEngine.h"

@interface QuakeDisaster : EggDisaster {
@private
    float quakeVelocity;
    float quakeDuration;
    float quakeFrequency;
    float quakeFriction;
    float oldFriction;
    ALuint mySoundID;
}

-(id) initWithDelay:(float)delay andStrength:(float)strength andFrequency:(float)frequency andFriction:(float)quakeFriction andDuration:(float)duration;

@end
