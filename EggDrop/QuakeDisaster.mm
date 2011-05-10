//
//  QuakeDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "QuakeDisaster.h"
#import "HelloWorldLayer.h"

@implementation QuakeDisaster

-(id) initWithDelay:(float)myDelay andStrength:(float)strength andFrequency:(float)frequency andFriction:(float)friction andDuration:(float)duration
{
    if((self = [super init]))
    {
        self->delay = myDelay;
        quakeVelocity = strength;
        quakeFrequency = frequency;
        quakeFriction = friction;
        quakeDuration = duration;
        disasterName = @"Quake";
        oldFriction = 0.2;
    }
    return self;
}

-(void) addDisasterToGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    mainLayer.quake = YES;
    mainLayer.quakeVelocity = self->quakeVelocity;
    mainLayer.quakeFrequency = self->quakeFrequency;
    
    mainLayer.quakeFloor->body->SetType(b2_dynamicBody);
    
    //now we have to increase that friction
    for(b2Fixture* f = mainLayer.quakeFloor->body->GetFixtureList(); f; f=f->GetNext())
    {
        oldFriction = f->GetFriction();
        f->SetFriction(quakeFriction);
    }
}

-(BOOL) isDisasterActive:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    return mainLayer.timeSinceLastDisaster < quakeDuration;
}

-(void) removeDisasterFromGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    mainLayer.quake = NO;
    
    mainLayer.quakeFloor->body->SetType(b2_staticBody);
    
    for(b2Fixture* f = mainLayer.quakeFloor->body->GetFixtureList(); f; f=f->GetNext())
    {
        f->SetFriction(oldFriction);
    }
    
}

-(id) copyWithZone:(NSZone*)zone
{
    QuakeDisaster * clone = [[QuakeDisaster allocWithZone:zone] initWithDelay:delay andStrength:quakeVelocity andFrequency:quakeFrequency andFriction:quakeFriction andDuration:quakeDuration];
    return clone;
}

-(NSString*)disasterDescription:(HelloWorldLayer *)mainLayer
{
    return [NSString stringWithFormat:@"Quake with frequency: %dhz ends in: %d", (int)quakeFrequency, (int)roundf(quakeDuration-mainLayer.timeSinceLastDisaster)]; 
}

-(CCSprite*) disasterIcon:(HelloWorldLayer*)mainLayer
{
    return [[CCSprite spriteWithFile:@"quake.png"] autorelease];
}


@end
