//
//  CushionEggBlock.m
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "CushionEggBlock.h"
#import "HelloWorldLayer.h"


@implementation CushionEggBlock

-(id) initWithRect:(CGRect)blockRect
{
    if((self = [super initWithRect:blockRect]))
    {
        blockType = @"cushion";
        density = 0.5;
    }
    return self;
}

-(void) loadGraphics:(CGRect)blockRect
{
    mySprite = [CCSprite spriteWithFile:@"cushiontexture.png"];
    mySprite.position = ccp(blockRect.origin.x, blockRect.origin.y);
    width = blockRect.size.width;
    height = blockRect.size.height;
    mySprite.scaleX = width/mySprite.contentSize.width;
    mySprite.scaleY = height/mySprite.contentSize.height;
    
    [self addChild:mySprite];
    desiredZ = 0;
}

-(BOOL)addToPhysicsWorld:(b2World*)world
{
    b2BodyDef blockBody;
    blockBody.type = b2_dynamicBody;
    blockBody.position.Set(mySprite.position.x/PTM_RATIO, mySprite.position.y/PTM_RATIO);
    blockBody.userData = self;
    blockBody.bullet = true;
    body = world->CreateBody(&blockBody);
    
    b2PolygonShape blockShape;
    blockShape.SetAsBox(width/PTM_RATIO/2, height/PTM_RATIO/2);
    b2FixtureDef blockFixture;
    blockFixture.shape = &blockShape;
    blockFixture.density = density;
    blockFixture.friction = friction;
    body->CreateFixture(&blockFixture);
    return YES;

}

-(id)copyWithZone:(NSZone*)zone
{
    CushionEggBlock *clone = [[CushionEggBlock allocWithZone:zone] initWithRect:CGRectMake(self.position.x, self.position.y, self.width, self.height)];
    return clone;
}


@end
