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

@synthesize width;
@synthesize height;

-(void) updateAddToWorld:(CGPoint)location
{
    self.position = location;
}


//various delegate methods
-(void) setPosition:(CGPoint)position
{
    mySprite.position = position;
}

-(CGPoint)position
{
    return mySprite.position;
}

-(void) setRotation:(float)rotation
{
    mySprite.rotation = rotation;
}

-(float) rotation
{
    return mySprite.rotation;
}

-(void) setAnchorPoint:(CGPoint)anchorPoint
{
    mySprite.anchorPoint = anchorPoint;
}

-(CGPoint) anchorPoint
{
    return mySprite.anchorPoint;
}

-(void) initiateAnchorPoint:(CGPoint)bodyGlobalCenter
{
    self.anchorPoint = ccp( (bodyGlobalCenter.x-self.position.x)/width+0.5, (bodyGlobalCenter.y-self.position.y)/height+0.5);
}

-(void) resolveAnchorPoint
{
    self.position = ccp(self.position.x + width*(self.anchorPoint.x-0.5), self.position.y+ height*(self.anchorPoint.y-0.5));
}

-(id) initWithRect:(CGRect)blockRect
{
    if((self = [super init]))
    {
        mySprite = [CCSprite spriteWithFile:@"woodblock.png"];
        mySprite.position = ccp(blockRect.origin.x, blockRect.origin.y);
        width = blockRect.size.width;
        height = blockRect.size.height;
        mySprite.scaleX = width/mySprite.contentSize.width;
        mySprite.scaleY = height/mySprite.contentSize.height;
        
        [self addChild:mySprite];
        desiredZ = 0;
    }
    return self;
}



-(void) updatePhysics
{
    
    
    mySprite.position = CGPointMake(body->GetPosition().x*PTM_RATIO, body->GetPosition().y*PTM_RATIO);
    mySprite.rotation = -1*CC_RADIANS_TO_DEGREES(body->GetAngle());
}

-(void)createFixture:(b2Body*)someBody
{
    b2PolygonShape blockShape;
    b2Vec2 center(mySprite.position.x/PTM_RATIO-someBody->GetPosition().x, mySprite.position.y/PTM_RATIO-someBody->GetPosition().y);
    blockShape.SetAsBox(width/PTM_RATIO/2, height/PTM_RATIO/2, center, CC_DEGREES_TO_RADIANS(mySprite.rotation));
    //blockShape.SetAsBox(width/PTM_RATIO/2, height/PTM_RATIO/2);
    b2FixtureDef blockFixture;
    blockFixture.shape = &blockShape;
    blockFixture.density = 1.5f;
    blockFixture.friction = 0.3f;
    blockFixture.userData = self;
    someBody->CreateFixture(&blockFixture);
}

-(BOOL) addToPhysicsWorld:(b2World*)world
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
    return YES;
}


@end
