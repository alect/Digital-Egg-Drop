//
//  MeteorDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 5/5/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "MeteorDisaster.h"


@implementation MeteorDisaster


-(id) initWithDelay:(float)metDelay andDuration:(float)metDuration
{
    if((self=[super init]))
    {
        delay = metDelay;
        duration = metDuration;
        meteorSprite = [[CCSprite spriteWithFile:@"meteor.png"] retain];
    }
    return self;
}

-(void) addDisasterToGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    
}

-(BOOL) isDisasterActive:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    return NO;
}

-(void) removeDisasterFromGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    
}

-(BOOL) addToPhysicsWorld:(b2World*)world
{
    return NO;
}

-(void) updatePhysics
{
    
}

-(void) dealloc
{
    [meteorSprite release];
    [super dealloc];
}

@end
