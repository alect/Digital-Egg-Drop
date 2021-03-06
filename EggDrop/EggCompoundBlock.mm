//
//  CompoundBlock.m
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "EggCompoundBlock.h"
#import "HelloWorldLayer.h"

@implementation EggCompoundBlock


-(id) initWithBlocks:(NSArray *)blocks
{
    if((self = [super init]))
    {
        blockList = [blocks retain];
        //now we need to go ahead and add all of the blocks as children so we can draw them.
        for(EggBlock* e in blockList)
        {
            [self addChild:e];
        }
        basePosition = CGPointZero;
    }
    return self;
}

//various delegate methods

//here we need to offset all of our children by the same amount
-(void) setPosition:(CGPoint)position
{
    CGPoint dPosition = ccp(position.x-basePosition.x, position.y-basePosition.y);
    for(EggBlock* e in blockList)
    {
        e.position = ccp(e.position.x+dPosition.x, e.position.y+dPosition.y);
    }
    basePosition = position;
}

-(CGPoint)position
{
    return basePosition;
}

-(void) setAnchorPoint:(CGPoint)anchorPoint
{
    CGPoint dAnchor = ccp(anchorPoint.x-baseAnchorPoint.x, anchorPoint.y-baseAnchorPoint.y);
    for(EggBlock* e in blockList)
    {
        e.anchorPoint = ccp(e.anchorPoint.x+dAnchor.x, e.anchorPoint.y+dAnchor.y);
    }
    baseAnchorPoint = anchorPoint;
}

-(void) resolveAnchorPoint
{
    for(EggBlock* e in blockList)
        [e resolveAnchorPoint];
}

-(void) initiateAnchorPoint:(CGPoint)bodyGlobalCenter
{
    for(EggBlock* e in blockList)
        [e initiateAnchorPoint:bodyGlobalCenter];
}


-(void) setRotation:(float)rotation
{
    float dRotation = rotation-baseRotation;
    for(EggBlock* e in blockList)
    {
        e.rotation += dRotation;
    }
    baseRotation = rotation;
}

-(float) rotation
{
    return baseRotation;
}

-(void)createFixture:(b2Body*)someBody
{
    for(EggBlock* e in blockList)
        [e createFixture:someBody];
}

-(BOOL) addToPhysicsWorld:(b2World*)world
{
    //add each block as a separate fixture
    b2BodyDef blockBody;
    blockBody.type = b2_dynamicBody;
    blockBody.position.Set(basePosition.x/PTM_RATIO, basePosition.y/PTM_RATIO);
    blockBody.userData = self;
    body = world->CreateBody(&blockBody);
    
    for(EggBlock* e in blockList)
    {
        [e createFixture:body];
    }
    //okay, this part was sort of nuts to figure out. It's basically the part that gets the goshdarn sprites positioned and rotated correctly around the
    //body. Whew!
    CGPoint bodyGlobalCenter = ccp(body->GetWorldCenter().x*PTM_RATIO, body->GetWorldCenter().y*PTM_RATIO);
    for(EggBlock* e in blockList)
    {
        [e initiateAnchorPoint:bodyGlobalCenter];
        [e resolveAnchorPoint];
    }
    
    return YES;
}

-(void) updatePhysics
{
    //notice that we're doing something a bit fancier here. This is gentle massaging to get the geometry to work out. 
    CGPoint localBody = ccp(body->GetLocalCenter().x*PTM_RATIO, body->GetLocalCenter().y*PTM_RATIO);
    self.position = CGPointMake(body->GetWorldCenter().x*PTM_RATIO-localBody.x, body->GetWorldCenter().y*PTM_RATIO-localBody.y);
    self.rotation = -1*CC_RADIANS_TO_DEGREES(body->GetAngle());
}

-(void)dealloc
{
    [blockList release];
    [super dealloc];
}

@end
