//
//  EggLevel.h
//  EggDrop
//
//  Created by Alec Thomson on 5/1/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Egg.h"

@interface EggLevel : NSObject {
    NSArray* objectsInPlace;
    NSArray* objectsToPlace;
    NSArray* disasters;
    Egg * myEgg;
}

@property(readonly) NSArray * objectsInPlace;
@property(readonly) NSArray * objectsToPlace;
@property(readonly) NSArray * disasters;
@property(readonly) Egg * myEgg;

-(id) initWithObjectsInPlace:(NSArray*)firstArray andObjectsToPlace:(NSArray*)secondArray andDisasters:(NSArray*)thirdArray andEgg:(Egg*)egg;

@end
