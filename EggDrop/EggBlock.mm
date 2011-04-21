//
//  Block.m
//  EggDrop
//
//  Created by Alec Thomson on 4/18/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggBlock.h"
#import "HelloWorldLayer.h"

@implementation EggBlock



-(id) initWithRect:(CGRect)blockRect
{
    if((self = [super init]))
    {
        mySprite = [CCSprite spriteWithFile:@"woodblocktexture.png"];
        mySprite.position = ccp(blockRect.origin.x, blockRect.origin.y);
        width = blockRect.size.width;
        height = blockRect.size.height;
        mySprite.scaleX = width/mySprite.contentSize.width;
        mySprite.scaleY = height/mySprite.contentSize.height;
        [self addChild:mySprite];
        
    }
    return self;
}



-(void) updatePhysics
{
    //myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
    //myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
    
    mySprite.position = CGPointMake(body->GetPosition().x*PTM_RATIO, body->GetPosition().y*PTM_RATIO);
    mySprite.rotation = -1*CC_RADIANS_TO_DEGREES(body->GetAngle());
}

-(void) addToPhysicsWorld:(b2World*)world
{
    b2BodyDef blockBody;
    blockBody.type = b2_dynamicBody;
    blockBody.position.Set(mySprite.position.x/PTM_RATIO, mySprite.position.y/PTM_RATIO);
    blockBody.userData = self;
    body = world->CreateBody(&blockBody);
    
    b2PolygonShape blockShape;
    blockShape.SetAsBox(width/PTM_RATIO/2, height/PTM_RATIO/2);
    b2FixtureDef blockFixture;
    blockFixture.shape = &blockShape;
    blockFixture.density = 1.5f;
    blockFixture.friction = 0.3f;
    body->CreateFixture(&blockFixture);
}


@end
