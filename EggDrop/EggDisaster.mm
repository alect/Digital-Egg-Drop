//
//  EggDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggDisaster.h"
#import "HelloWorldLayer.h"

@implementation EggDisaster

@synthesize delay;
@synthesize disasterName;

-(id) init
{
    if((self = [super init]))
    {
        disasterName = @"disaster";
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

-(NSString*) disasterDescription:(HelloWorldLayer*)mainLayer
{
    return @"Disaster!";
}


@end
