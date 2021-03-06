//
//  StrawEggBlock.h
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggBlock.h"
#import "BreakablePhysicalObject.h"

@interface StrawEggBlock : EggBlock <BreakablePhysicalObject> {
    float totalImpulse;
    float impulseLimit;
    float baseImpulse;
}

@end
