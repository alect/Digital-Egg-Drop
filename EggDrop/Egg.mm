//
//  Egg.m
//  EggDrop
//
//  Created by Alec Thomson on 4/18/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "Egg.h"
#import <Math.h>
#import "HelloWorldLayer.h"

@implementation Egg

-(id) initWithPos:(CGPoint)position
{
    if((self = [super init]))
    {
        mySprite = [CCSprite spriteWithFile:@"LonLonEggSprite4.png"];
        mySprite.position = ccp(position.x, position.y);
        radius = fminf(mySprite.contentSize.width, mySprite.contentSize.height)/2;
        [self addChild:mySprite];
    }
    return self;
}

-(void) addToPhysicsWorld:(b2World*)world
{
    b2BodyDef eggBody;
    eggBody.type = b2_dynamicBody;
    eggBody.position.Set(mySprite.position.x/PTM_RATIO, mySprite.position.y/PTM_RATIO);
    eggBody.userData = self;
    body = world->CreateBody(&eggBody);
    
    b2CircleShape eggShape;
    eggShape.m_radius = radius/PTM_RATIO;
    b2FixtureDef eggFixture;
    eggFixture.shape = &eggShape;
    eggFixture.density = 1.0f;
    eggFixture.friction = 0.3f;
    body->CreateFixture(&eggFixture);
}

-(void) updatePhysics
{
    mySprite.position = CGPointMake(body->GetPosition().x*PTM_RATIO, body->GetPosition().y*PTM_RATIO);
    mySprite.rotation = -1*CC_RADIANS_TO_DEGREES(body->GetAngle());
}


@end
