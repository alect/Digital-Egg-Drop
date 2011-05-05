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
    
    //easy intro level here
    EggLevel *easyLevel = [[[EggLevel alloc] initWithObjectsInPlace:[NSArray arrayWithObjects:[[[EggBlock alloc] initWithRect:CGRectMake(100, 110, 30, 150)] autorelease], nil] 
                                                  andObjectsToPlace:[NSArray arrayWithObjects:[[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 40)] autorelease],
                                                                     [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 40)] autorelease],
                                                                     [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 40)] autorelease],nil]  
                                                       andDisasters:[NSArray arrayWithObjects:[[[WindDisaster alloc] initWithDelay:3 andStrength:2.5 andDuration:5] autorelease], nil] 
                                                             andEgg:[[[Egg alloc] initWithPos:ccp(250, 60)] autorelease]] autorelease];
    
    
    //zeroth level here. 
    EggLevel *levelZero = [[[EggLevel alloc] initWithObjectsInPlace:[NSArray array] 
                                                                     andObjectsToPlace:[NSArray arrayWithObjects:[[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 50)] autorelease],
                                                                                                                [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 50)] autorelease],
                                                                                                                [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 50)] autorelease],
                                                                                                                [[[EggNail alloc] init] autorelease], nil] 
                                                                     andDisasters:[NSArray arrayWithObjects:[[[WindDisaster alloc] initWithDelay:3 andStrength:5 andDuration:5] autorelease], nil] 
                                                                     andEgg:[[[Egg alloc] initWithPos:ccp(200, 60)] autorelease]
                                                                     ] autorelease];
    
    
    //first level right here
    EggLevel *firstLevel = [[[EggLevel alloc] initWithObjectsInPlace:[NSArray array]
                                                   andObjectsToPlace:[NSArray arrayWithObjects:[[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 30, 100)] autorelease],
                                                                       [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 60, 60)] autorelease],
                                                                       [[[EggNail alloc] init] autorelease],
                                                                       [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 50)] autorelease],
                                                                       nil]
                                                        andDisasters:[NSArray arrayWithObjects:[[[WindDisaster alloc] initWithDelay:3 andStrength:2 andDuration:4] autorelease],
                                                                       [[[QuakeDisaster alloc] initWithDelay:3 andStrength:50 andFrequency:2 andFriction:3 andDuration:10] autorelease],
                                                                       [[[WindDisaster alloc] initWithDelay:3 andStrength:3  andDuration:2] autorelease],
                                                                       nil]
                                                              andEgg:[[[Egg alloc] initWithPos:ccp(200, 60)] autorelease]
                             ] autorelease];
    
    EggLevel *thirdLevel = [[[EggLevel alloc] initWithObjectsInPlace: [NSArray arrayWithObjects:[[[EggBlock alloc] initWithRect:CGRectMake(100, 200, 30, 200)] autorelease], 
                                                                       [[[EggBlock alloc] initWithRect:CGRectMake(300, 200, 30, 200)] autorelease], nil]
                                                   andObjectsToPlace:[NSArray arrayWithObjects:[[[EggNail alloc] init] autorelease], nil]
                                                        andDisasters:[NSArray arrayWithObjects:[[[QuakeDisaster alloc] initWithDelay:3 andStrength:50 andFrequency:2 andFriction:4 andDuration:5] autorelease], nil] 
                                                              andEgg:[[[Egg alloc] initWithPos:ccp(200, 60)] autorelease]] autorelease];
    
    
    levelArray = [[NSArray arrayWithObjects:easyLevel, levelZero, firstLevel, thirdLevel, nil] retain];
}

+(NSArray*)levelList {return levelArray;}

@end
