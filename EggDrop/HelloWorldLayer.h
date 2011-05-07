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
#import "LevelParser.h"
#import "PlaceableNode.h"
#import "EggDisaster.h"
#import "EggBlock.h"
#import "EggLevel.h"
//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

typedef enum {paused, placingObjects, runningDisasters, eggBroken, levelWon} gameState;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	b2World* world;
	GLESDebugDraw *m_debugDraw;
    CCLabelTTF *stateLabel;
    CCLabelTTF *eggLabel;
    
    //the block used to represent the floor for earthquakes
    EggBlock * quakeFloor;
    BOOL quake;
    float quakeFrequency;
    float quakeVelocity;
    
   
    BOOL eggAlreadyBroken;
    BOOL windy;
    
    //the wind strength of the wind. Officially in Newton's. Be aware however, that an item in the way of the wind will be pelted at multiple points per step.
    float windStrength;
    NSMutableArray *objectsToPlace;
    PlaceableNode <PhysicalObject> *objectToPlace;
    CCLabelTTF *nextLabel;
    PlaceableNode *nextObjectToPlace;
    
    //the amount of time in seconds since the last disaster started
    float timeSinceLastDisaster; 
    
    //our list of disasters
    NSMutableArray *disasters;
    //our current disaster
    EggDisaster *currentDisaster;
    
    gameState state;
    LevelParser *myParser;
    EggLevel * currentLevel;
    int currentLevelIndex;
    
    //keeping a reference of our menu here
    CCMenu *myUI;
    CCMenuItem *nextLevelButton;
    
@public
    Egg *myEgg;
    
}

@property BOOL windy;
@property float windStrength;

@property BOOL quake;
@property float quakeVelocity;
@property float quakeFrequency;
@property(readonly) EggBlock* quakeFloor;

@property float timeSinceLastDisaster;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


//clears the current level so that we can load the next one
-(void) clearLevel;
//loads all relevant objects from a level.
-(void) loadFromLevel:(EggLevel*)level;


@end
