//
//  CompoundBlock.h
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggBlock.h"
#import "Box2D.h"

@interface EggCompoundBlock : EggBlock {
    NSArray *blockList;
    CGPoint basePosition;
    float baseRotation;
}


//Function that initializes this compound block such that it's made out of all of its children
//the initial position of its children becomes their offset with reference to this block. 
-(id) initWithBlocks:(NSArray*)blocks;

@end
