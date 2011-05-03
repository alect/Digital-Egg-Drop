//
//  EggNail.h
//  EggDrop
//
//  Created by Alec Thomson on 4/24/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "HelloWorldLayer.h"
#import "PhysicalObject.h"
#import "PlaceableNode.h"


//the egg nail is essentially a "strap" that can be used to connect two other objects together. 
//It's drawn by three components, the strap 
@interface EggNail : PlaceableNode <PhysicalObject> {
    
    CCSprite * strapEnd; 
    CCSprite * strapMiddle;
    b2Joint * strapJoint; 
    
    CGPoint firstAnchor;
    CGPoint secondAnchor;
    
    b2Vec2 localA, localB;
}

-(id) initWithAnchor1:(CGPoint)anchor1 andAnchor2:(CGPoint)anchor2;

@end
