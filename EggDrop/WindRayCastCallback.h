//
//  WindRayCastCallback.h
//  EggDrop
//
//  Created by Alec Thomson on 4/29/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//
#include "Box2D.h"

#ifndef WIND_RAY_CAST_CALLBACK_H
#define WIND_RAY_CAST_CALLBACK_H

class WindRayCastCallback: public b2RayCastCallback
{
public:
    WindRayCastCallback() {}
    virtual float32 ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float32 fraction);
};

#endif