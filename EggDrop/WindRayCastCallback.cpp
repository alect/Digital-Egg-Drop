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
    std::cout << "HELLO" << std::endl;
    
    std::cout << point.x*32 << " " << point.y*32 << std::endl;
    
    b2Body* body = fixture->GetBody();
    body->ApplyForce(b2Vec2(2, 0), point);
    
    return fraction;
}