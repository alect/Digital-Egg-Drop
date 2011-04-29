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
    b2Body *body;
    CCSprite *mySprite;
    float width;
    float height;
    
}

@property(readonly) float width;
@property(readonly) float height;

-(id) initWithRect:(CGRect)blockRect;
-(void) createFixture:(b2Body*)someBody;
-(void) initiateAnchorPoint:(CGPoint)bodyGlobalCenter;
-(void) resolveAnchorPoint;

@end
