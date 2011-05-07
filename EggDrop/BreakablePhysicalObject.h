//
//  BreakablePhysicalObject.h
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalObject.h"

@protocol BreakablePhysicalObject <PhysicalObject>

//called after updatePhysics to see if we need to remove this object from physics
-(BOOL) shouldRemoveFromPhysics;

//called to actually remove the object from physics. 
-(void) removeFromPhysicsWorld:(b2World*)world;

@end
