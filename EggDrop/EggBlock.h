//
//  Block.h
//  EggDrop
//
//  Created by Alec Thomson on 4/18/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalObject.h"
#import "cocos2d.h"
#import "Box2D.h"
#import "PlaceableNode.h"

@interface EggBlock : PlaceableNode <PhysicalObject> {
@public
    b2Body *body;
@protected
    CCSprite *mySprite;
    float width;
    float height;
    float startRotation;
    
}

@property(readonly) float width;
@property(readonly) float height;
@property float startRotation;

-(id) initWithRect:(CGRect)blockRect;
-(void) createFixture:(b2Body*)someBody;
-(void) initiateAnchorPoint:(CGPoint)bodyGlobalCenter;
-(void) resolveAnchorPoint;

@end
