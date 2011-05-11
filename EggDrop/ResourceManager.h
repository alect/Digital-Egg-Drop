//
//  ResourceManager.h
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


//some definitions for our sound constants
#define WIND_SOUND 0
#define QUAKE_SOUND 1

//a class for containing all the static resources such as the levels. 
@interface ResourceManager : NSObject {
    
}


+(NSArray*)levelList;
+(NSArray*)xmlLevelList;
+(NSArray*)tutorialList;

@end
