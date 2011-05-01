//
//  WindRayCastCallback.cpp
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#include <iostream>
#include "WindRayCastCallback.h"

float32 WindRayCastCallback::ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float32 fraction)
{    
    b2Body* body = fixture->GetBody();
    body->ApplyForce(b2Vec2(strength, 0), point);
    //we return the given fraction specifically so that we don't continue the ray any farther. 
    return fraction;
}