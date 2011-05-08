//
//  CloudBlockDisaster.h
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggDisaster.h"
#import "CloudEggBlock.h"
@interface CloudBlockDisaster : EggDisaster {
    float duration;
}


-(id) initWithDelay:(float)_delay andDuration:(float)_duration;

@end
