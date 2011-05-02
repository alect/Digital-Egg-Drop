//
//  EggLevel.m
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggLevel.h"


@implementation EggLevel

@synthesize objectsInPlace;
@synthesize objectsToPlace;
@synthesize disasters;
@synthesize myEgg;

-(id) initWithObjectsInPlace:(NSArray *)firstArray andObjectsToPlace:(NSArray *)secondArray andDisasters:(NSArray *)thirdArray andEgg:(Egg*)egg
{
    if((self=[super init]))
    {
    
        objectsInPlace = [firstArray retain];
        objectsToPlace = [secondArray retain];
        disasters = [thirdArray retain];
        myEgg = [egg retain];
    }
    return self;
}

-(void) dealloc
{
    [objectsInPlace release];
    [objectsToPlace release];
    [disasters release];
    [myEgg release];
    [super dealloc];
}


@end
