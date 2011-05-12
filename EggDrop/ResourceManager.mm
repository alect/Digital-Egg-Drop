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
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"

@implementation ResourceManager


static NSArray *levelArray;
static NSArray *xmlLevelArray;
static NSArray *tutorialArray;



+(void) initialize
{
    
    EggTutorial* tutorial0 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"interfaceTour1.png", @"interfaceTour2.png", @"interfaceTour3.png", @"interfaceTour4.png", nil] 
                               ]autorelease];
    
    //EggTutorial* tutorial1 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newWoodBlock.png", @"newStrawBlock.png", @"newBrickBlock.png", @"newMeteor.png", nil] 
    //                                ]autorelease];
   
    EggTutorial* tutorial1 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newWoodBlock.png", @"newWind.png", nil]] autorelease];
    
    EggTutorial* tutorial2 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newStrawBlock.png", @"newNail.png", nil]] autorelease];
    
    EggTutorial* tutorial3 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newBrickBlock.png", @"newMeteor.png", nil] 
                               ]autorelease];
    
    EggTutorial* tutorial4 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newRottingBlock.png", nil]] autorelease];
    
    EggTutorial* tutorial5 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newCushion.png", @"newQuake.png", nil]] autorelease];
    
    EggTutorial* tutorial6 = [[[EggTutorial alloc] initWithScenes:[NSArray arrayWithObjects:@"newHinge.png", nil] 
                               ]autorelease];
    
    tutorialArray = [[NSArray arrayWithObjects:tutorial0, tutorial1, tutorial2, tutorial3, tutorial4, tutorial5, tutorial6, nil] retain];
    
    xmlLevelArray = [[NSArray arrayWithObjects:@"Tutorial", @"Tutorial", @"kidlevel1", @"Tutorial", @"kidlevel2", @"Tutorial", @"kidlevel3", @"Tutorial", @"kidlevel4", @"Tutorial", @"kidlevel5", @"level3", @"Tutorial", @"level5", @"level4", @"meteortest", @"lamont_level_test", @"levelZero", @"easy", @"firstLevel", @"thirdLevel", nil] retain];

    
    
    
    //load all our audio effects. 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"breaking_egg_glass.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"wind.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"earthquake.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hammer_click.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"rotting_wood.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"staw_blowing_away.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"wrong_placement.caf"];
    
    
    
}


+(NSArray*)levelList {return levelArray;}

+(NSArray*)xmlLevelList{return xmlLevelArray;}

+(NSArray*)tutorialList{return tutorialArray;}

@end
