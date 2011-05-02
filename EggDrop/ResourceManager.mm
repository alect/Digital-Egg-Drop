//
//  ResourceManager.m
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "ResourceManager.h"
#import "EggLevel.h"
#import "EggBlock.h"
#import "Egg.h"
#import "EggNail.h"
#import "EggHinge.h"
#import "cocos2d.h"
#import "WindDisaster.h"
#import "QuakeDisaster.h"

@implementation ResourceManager


static NSArray *levelArray;

+(void) initialize
{
    //first level right here
    EggLevel *firstLevel = [[[EggLevel alloc] initWithObjectsInPlace:[[NSArray array] autorelease]
                                                   andObjectsToPlace:[[NSArray arrayWithObjects:[[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 12, 200)] autorelease],
                                                                       [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 60, 60)] autorelease],
                                                                       [[[EggNail alloc] init] autorelease],
                                                                       [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 50)] autorelease],
                                                                       nil] autorelease]
                                                        andDisasters:[[NSArray arrayWithObjects:[[[WindDisaster alloc] initWithDelay:3 andStrength:2 andDuration:4] autorelease],
                                                                       [[[QuakeDisaster alloc] initWithDelay:3 andStrength:50 andFrequency:2 andFriction:3 andDuration:10] autorelease],
                                                                       [[[WindDisaster alloc] initWithDelay:3 andStrength:3  andDuration:2] autorelease],
                                                                       nil]
                                                                      autorelease]
                                                              andEgg:[[[Egg alloc] initWithPos:ccp(200, 60)] autorelease]
                             ] autorelease];
    levelArray = [[NSArray arrayWithObjects:firstLevel, nil] retain];
}

+(NSArray*)levelList {return levelArray;}

@end
