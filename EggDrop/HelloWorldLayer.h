//
//  HelloWorldLayer.h
//  EggDrop
//
//  Created by Alec Thomson on 4/17/11.
//  Copyright Massachusetts Institute of Technology 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "PhysicalObject.h"
#import "Egg.h"
#import "PlaceableNode.h"
//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32


// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	b2World* world;
	GLESDebugDraw *m_debugDraw;
    CCLabelTTF *stateLabel;
    CCLabelTTF *eggLabel;
    Egg *myEgg;
    BOOL eggAlreadyBroken;
    NSMutableArray *objectsToPlace;
    PlaceableNode <PhysicalObject> *objectToPlace;
    CCLabelTTF *nextLabel;
    PlaceableNode *nextObjectToPlace;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
