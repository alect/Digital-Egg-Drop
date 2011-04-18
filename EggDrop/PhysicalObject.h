//
//  PhysicalObject.h
//  EggDrop
//
//  Created by Alec Thomson on 4/18/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"

@protocol PhysicalObject <NSObject>

-(void) addToPhysicsWorld:(b2World*)world;
-(void) updatePhysics;

@end
