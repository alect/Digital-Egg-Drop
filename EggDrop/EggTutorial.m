//
//  EggTutorial.m
//  EggDrop
//
//  Created by Sarah Lehmann on 5/9/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggTutorial.h"


@implementation EggTutorial

@synthesize scenes;

-(id) initWithScenes:(NSArray*)sceneArray;
{
    if((self=[super init]))
    {
        
        self->scenes = [sceneArray retain];
    
    }
    return self;
}

@end
