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
    
        self->objectsInPlace = [firstArray retain];
        self->objectsToPlace = [secondArray retain];
        self->disasters = [thirdArray retain];
        myEgg = [egg retain];
    }
    return self;
}

-(void) dealloc
{
    NSLog(@"OH SHIT!!!");
    [objectsInPlace release];
    [objectsToPlace release];
    [disasters release];
    [myEgg release];
    [super dealloc];
}


@end
