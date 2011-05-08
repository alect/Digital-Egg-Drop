//
//  PlaceableNode.h
//  EggDrop
//
//  Created by Alec Thomson on 4/27/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/**
 An abstract object that essentially represents a node that can be placed in the world by a player. 
 Extended by Blocks, Nails, and Bearings
 */
@interface PlaceableNode : CCNode {
    int desiredZ;
}

@property int desiredZ;

-(void) beginAddToWorld:(CGPoint)location;
-(void) updateAddToWorld:(CGPoint)location;
-(void) resetToPosition:(CGSize)size atPoint:(CGPoint)location;

@end
