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
static NSArray *xmlLevelArray;

+(void) initialize
{
    
    xmlLevelArray = [[NSArray arrayWithObjects:@"level1", @"level2", @"level3", @"level4", @"meteortest", @"lamont_level_test", @"levelZero", @"easy", @"firstLevel", @"thirdLevel", nil] retain];
}

+(NSArray*)levelList {return levelArray;}

+(NSArray*)xmlLevelList{return xmlLevelArray;}

@end
