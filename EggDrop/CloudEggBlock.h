//
//  CloudEggBlock.h
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggBlock.h"
#import "HelloWorldLayer.h"

@interface CloudEggBlock : EggBlock {
    
}

-(void) removeFromGame:(HelloWorldLayer*)mainLayer andPhysicsWorld:(b2World*)world;

@end
