//
//  ResourceManager.m
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "ResourceManager.h"
#import "EggLevel.h"
#import "EggTutorial.h"
#import "EggBlock.h"
#import "Egg.h"
#import "EggNail.h"
#import "EggHinge.h"
#import "cocos2d.h"
#import "WindDisaster.h"
#import "QuakeDisaster.h"

@implementation ResourceManager


static NSArray *levelArray;
static NSArray *xmlLevelArray;
static NSArray *tutorialArray;

+(void) initialize
{
    
    EggTutorial* tutorialEasy = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"background.png", @"background.png", nil] 
                                    ]autorelease];
    
    xmlLevelArray = [[NSArray arrayWithObjects:@"Tutorial", @"meteortest", @"Tutorial", @"lamont_level_test", @"levelZero", @"easy", @"firstLevel", @"thirdLevel", nil] retain];
    
    tutorialArray = [[NSArray arrayWithObjects:tutorialEasy, tutorialEasy, nil] retain];
    
    
}

+(NSArray*)levelList {return levelArray;}

+(NSArray*)xmlLevelList{return xmlLevelArray;}

+(NSArray*)tutorialList{return tutorialArray;}

@end
