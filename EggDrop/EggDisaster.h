//
//  EggDisaster.h
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "Box2D.h"

@class HelloWorldLayer;

@interface EggDisaster : NSObject {
    float delay;
    NSString *disasterName;
}


@property(readonly) float delay;
@property(readonly) NSString* disasterName;


-(void) addDisasterToGame:(HelloWorldLayer*)mainLayer withWorld:(b2World*)world;
-(BOOL) isDisasterActive:(HelloWorldLayer*)mainLayer withWorld:(b2World*)world;
-(void) removeDisasterFromGame:(HelloWorldLayer*)mainLayer withWorld:(b2World*)world;

-(NSString*) disasterDescription:(HelloWorldLayer*)mainLayer;
-(CCSprite*) disasterIcon:(HelloWorldLayer*)mainLayer;

@end
