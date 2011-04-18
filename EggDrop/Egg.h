//
//  Egg.h
//  EggDrop
//
//  Created by Alec Thomson on 4/18/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalObject.h"
#import "cocos2d.h"
#import "Box2D.h"

@interface Egg : CCNode <PhysicalObject> {
    CCSprite* mySprite;
    b2Body* body;
    float radius;
}

-(id) initWithPos:(CGPoint)position;

@end
