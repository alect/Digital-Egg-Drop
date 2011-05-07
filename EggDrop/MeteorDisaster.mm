//
//  MeteorDisaster.m
//  EggDrop
//
//  Created by Alec Thomson on 5/5/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "MeteorDisaster.h"


@implementation MeteorDisaster


-(id) initWithDelay:(float)metDelay andDuration:(float)metDuration
{
    if((self=[super init]))
    {
        delay = metDelay;
        duration = metDuration;
        meteorSprite = [[CCSprite spriteWithFile:@"meteor.png"] retain];
    }
    return self;
}

-(void) addDisasterToGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    meteorSprite.position = ccp(mainLayer->myEgg.position.x, 600); 
    [mainLayer addChild:meteorSprite];
    [self addToPhysicsWorld:world];
}

-(BOOL) isDisasterActive:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    
    return mainLayer.timeSinceLastDisaster < duration;
}

-(void) removeDisasterFromGame:(HelloWorldLayer *)mainLayer withWorld:(b2World*)world
{
    //don't need to do anything to be removed from world.
}

-(BOOL) addToPhysicsWorld:(b2World*)world
{
    b2BodyDef meteorBody;
    meteorBody.type = b2_dynamicBody;
    meteorBody.position.Set(meteorSprite.position.x/PTM_RATIO, meteorSprite.position.y/PTM_RATIO);
    meteorBody.userData = self;
    body = world->CreateBody(&meteorBody);
    
    float radius = fminf(meteorSprite.contentSize.width, meteorSprite.contentSize.height);
    
    b2CircleShape meteorShape;
    meteorShape.m_radius = radius/PTM_RATIO/2;
    b2FixtureDef meteorFixture;
    meteorFixture.shape = &meteorShape;
    meteorFixture.density = 4.0f;
    meteorFixture.friction = 0.3f;
    body->CreateFixture(&meteorFixture);
    
    return YES;
    
}

-(void) updatePhysics
{
    meteorSprite.position = CGPointMake(body->GetPosition().x*PTM_RATIO, body->GetPosition().y*PTM_RATIO);
    meteorSprite.rotation = -1*CC_RADIANS_TO_DEGREES(body->GetAngle());
}

-(void) dealloc
{
    [meteorSprite release];
    [super dealloc];
}

-(id) copyWithZone:(NSZone*)zone
{
    MeteorDisaster * clone = [[MeteorDisaster alloc] initWithDelay:delay andDuration:duration];
    return clone;
}

@end
