//
//  MeteorDisaster.h
//  EggDrop
//
//  Created by Alec Thomson on 5/5/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggDisaster.h"
#import "PhysicalObject.h"
#import "Box2D.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"


//A simple disaster that represents a meteor. 
//Right now, it simply spawns a meteor above the player. 
@interface MeteorDisaster : EggDisaster <PhysicalObject> {
    b2Body *body;
    CCSprite *meteorSprite;
    float duration;
}

-(id) initWithDelay:(float)metDelay andDuration:(float)metDuration;

@end
