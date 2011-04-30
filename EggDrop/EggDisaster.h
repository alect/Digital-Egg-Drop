//
//  EggDisaster.h
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"
#import "cocos2d.h"
#import "Box2D.h"

@interface EggDisaster : NSObject {
    
}

-(void) addDisasterToGame:(HelloWorldLayer*)mainLayer withWorld:(b2World*)world;

@end
