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
#import "CushionEggBlock.h"

@implementation Egg

-(CGPoint) position
{
    return mySprite.position;
}


-(void) setBroken:(BOOL)newBroken
{
    if(newBroken != broken)
    {
        broken = newBroken;
        CGPoint oldPos = mySprite.position;
        float oldRot = mySprite.rotation;
        [self removeChild:mySprite cleanup:YES];
        if(broken)
            mySprite = brokenSprite;
        else
            mySprite = normalSprite;
        mySprite.position = oldPos;
        mySprite.rotation = oldRot;
        [self addChild:mySprite];
        
    }
}

-(BOOL) broken
{
    return broken;
}


-(id) initWithPos:(CGPoint)position
{
    if((self = [super init]))
    {
        broken = NO;
        normalSprite = [[CCSprite spriteWithFile:@"egg.png"] retain];
        brokenSprite = [[CCSprite spriteWithFile:@"cracked_egg.png"] retain];
        mySprite = normalSprite;
        mySprite.position = ccp(position.x, position.y);
        radius = fminf(mySprite.contentSize.width, mySprite.contentSize.height)/2;
        [self addChild:mySprite];
        baseImpulse = -1;
    }
    return self;
}



-(BOOL) addToPhysicsWorld:(b2World*)world
{
    b2BodyDef eggBody;
    eggBody.type = b2_dynamicBody;
    eggBody.position.Set(mySprite.position.x/PTM_RATIO, mySprite.position.y/PTM_RATIO);
    eggBody.bullet = true;
    eggBody.userData = self;
    body = world->CreateBody(&eggBody);
    
    b2CircleShape eggShape;
    eggShape.m_radius = radius/PTM_RATIO;
    b2FixtureDef eggFixture;
    eggFixture.shape = &eggShape;
    eggFixture.density = 1.0f;
    eggFixture.friction = 0.3f;
    body->CreateFixture(&eggFixture);
    return YES;
}

-(void) updatePhysics
{
    mySprite.position = CGPointMake(body->GetPosition().x*PTM_RATIO, body->GetPosition().y*PTM_RATIO);
    mySprite.rotation = -1*CC_RADIANS_TO_DEGREES(body->GetAngle());
    float max_impulse = 0;
    //now we want to test for impulses that would break the egg. 
    for (b2ContactEdge* ce = body->GetContactList(); ce; ce = ce->next)
    {
        //check to see if we're dealing with a cushion first. If so, we don't apply any impulse. 
        //this code is a little sloppy, but I think it's acceptable. 
        if(ce->other->GetUserData() != NULL && [(id)(ce->other->GetUserData()) class] == [CushionEggBlock class])
        {
            continue;
        }
        
        
        b2Contact* c = ce->contact;
        
        // process c
        b2Manifold* myManifold = c->GetManifold();
        for(int i = 0; i < b2_maxManifoldPoints; i++)
        {
            b2ManifoldPoint mPoint = myManifold->points[i];
            if(mPoint.normalImpulse > max_impulse)
                max_impulse = mPoint.normalImpulse;
        }
        
    }
    //need to wait until the transient impulse disapears before allowing the egg to be broken.
    if(baseImpulse == -1 || baseImpulse > 9)
    {
        NSLog(@"starting Impulse: %f", max_impulse);
        baseImpulse = max_impulse;
    }
    else if(fabsf(max_impulse) > 9)
    {
        NSLog(@"Egg Broken!!!: %f", max_impulse);
        self.broken = YES;
    }
}


-(id) copyWithZone:(NSZone*)zone
{
    Egg * clone = [[Egg allocWithZone:zone] initWithPos:ccp(mySprite.position.x, mySprite.position.y)] ;
    return clone;
}

-(void) dealloc
{
    [normalSprite release];
    [brokenSprite release];
    [super dealloc];
}

@end
