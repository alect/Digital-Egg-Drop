//
//  HelloWorldLayer.mm
//  EggDrop
//
//  Created by Alec Thomson on 4/17/11.
//  Copyright Massachusetts Institute of Technology 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "EggBlock.h"
#import "EggNail.h"

// enums that will be used as tags
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
};



// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//this let's us receive single touches.
-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// enable touches
		self.isTouchEnabled = YES;
		
		// enable accelerometer
		self.isAccelerometerEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
		
		// Define the gravity vector.
		b2Vec2 gravity;
		gravity.Set(0.0f, -10.0f);
		
		// Do we want to let bodies sleep?
		// This will speed up the physics simulation
		bool doSleep = true;
		
		// Construct a world object, which will hold and simulate the rigid bodies.
		world = new b2World(gravity, doSleep);
		
        //Alec: I believe this should avoid the problem of tunneling, but decrease performance. Something to keep in min. 
		world->SetContinuousPhysics(true);
		
		// Debug Draw functions
		m_debugDraw = new GLESDebugDraw( PTM_RATIO );
		world->SetDebugDraw(m_debugDraw);
		
		uint32 flags = 0;
//		flags += b2DebugDraw::e_shapeBit;
//		flags += b2DebugDraw::e_jointBit;
//		flags += b2DebugDraw::e_aabbBit;
//		flags += b2DebugDraw::e_pairBit;
//		flags += b2DebugDraw::e_centerOfMassBit;
		m_debugDraw->SetFlags(flags);		
		
		
        
        //Here is where we create the boundaries of the world
		// Define the ground body.
		b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0); // bottom-left corner
		
		// Call the body factory which allocates memory for the ground body
		// from a pool and creates the ground box shape (also from a pool).
		// The body is also added to the world.
		b2Body* groundBody = world->CreateBody(&groundBodyDef);
		
		// Define the ground box shape.
		b2PolygonShape groundBox;		
		
		// bottom
		groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
		groundBody->CreateFixture(&groundBox,0);
		
		// top
		groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
		
		// left
		groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
		groundBody->CreateFixture(&groundBox,0);
		
		// right
		groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
		groundBody->CreateFixture(&groundBox,0);
		
		//Set up sprite
		
		//[self addNewSpriteWithCoords:ccp(screenSize.width/2, screenSize.height/2)];
        myEgg = [[[Egg alloc] initWithPos:ccp(50, 20)] autorelease];
        [myEgg addToPhysicsWorld:world];
        [self addChild:myEgg];
        eggAlreadyBroken = NO;
        
        
		//stateLabel = [CCLabelTTF labelWithString:@"place objects" fontName:@"Arial" fontSize:22];
		stateLabel = [CCLabelTTF labelWithString:@"place objects" dimensions:CGSizeMake(screenSize.width, 30) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:22];
        
        [self addChild:stateLabel z:0];
		[stateLabel setColor:ccc3(255,255,255)];
		stateLabel.position = ccp( screenSize.width/2, screenSize.height-60);
		
        //eggLabel = [CCLabelTTF labelWithString:@"Egg Status: Okay!" fontName:@"Arial" fontSize:18];
        eggLabel = [CCLabelTTF labelWithString:@"Egg Status: Okay!" dimensions:CGSizeMake(screenSize.width, 30) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:18];
        [self addChild:eggLabel z:0];
        [eggLabel setColor:ccc3(255, 255, 255)];
        eggLabel.position = ccp(screenSize.width/2, screenSize.height-40);
        
        
        //create a simple Array to test out the various kinds of objects we can add to the game
        objectsToPlace = [[NSMutableArray arrayWithObjects:
                            [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 12, 50)] autorelease],
                            [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 12)] autorelease],
                            [[[EggNail alloc] init] autorelease],
                            [[[EggBlock alloc] initWithRect:CGRectMake(0, 0, 50, 50)] autorelease],
                            
                            nil] retain];
        
        
        
        nextLabel = [CCLabelTTF labelWithString:@"Next:" dimensions:CGSizeMake(100, 30) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:18];
        [self addChild:nextLabel z:0];
        [nextLabel setColor:ccc3(255, 255, 255)];
        nextLabel.position = ccp(460, 300);
        
        nextObjectToPlace = [objectsToPlace objectAtIndex:0];
        nextObjectToPlace.position = ccp(440, 270);
        [self addChild:nextObjectToPlace];
        
		[self schedule: @selector(tick:)];
	}
	return self;
}

-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

}

-(void) tick: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);

	
	//Iterate over the bodies in the physics world. This is where we call the updatePhysics function. 
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL && [((id)b->GetUserData()) conformsToProtocol:@protocol(PhysicalObject) ]) {
            id <PhysicalObject> myObject = (id <PhysicalObject>)b->GetUserData();
            [myObject updatePhysics];
		}	
	}
    for (b2Joint* j = world->GetJointList(); j; j=j->GetNext())
    {
        if(j->GetUserData() != NULL && [((id)j->GetUserData()) conformsToProtocol:@protocol(PhysicalObject)]) {
            id <PhysicalObject> myObject = (id <PhysicalObject>)j->GetUserData();
            [myObject updatePhysics];
        }
    }
    if(myEgg.broken && !eggAlreadyBroken)
    {
        [eggLabel setString:@"Egg: broken!!"];
        eggAlreadyBroken = YES;
    }
    if([objectsToPlace count] == 0)
        [stateLabel setString:@"No more objects. Begin disasters!"];

    
    
    
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"HELLO");
    if(objectToPlace != nil || [objectsToPlace count] == 0)
        return NO;
    
    //first, remove this object from the "next" preview
    [self removeChild:nextObjectToPlace cleanup:YES];
    
    //go ahead and add this object
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    objectToPlace = [objectsToPlace objectAtIndex:0];
    objectToPlace.position = ccp(location.x, location.y);
    [objectToPlace beginAddToWorld:location];
    
    [self addChild:objectToPlace z:objectToPlace.desiredZ];
    
    if([objectsToPlace count] > 1)
    {
        nextObjectToPlace = [objectsToPlace objectAtIndex:1];
        nextObjectToPlace.position = ccp(440, 270);
        [self addChild:nextObjectToPlace];
    }
    
    NSLog(@"HELLO AGAIN");
    return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(objectToPlace == nil)
        return;
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    //objectToPlace.position = ccp(location.x, location.y);
    [objectToPlace updateAddToWorld:location];
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(objectToPlace == nil)
        return;

    if([objectToPlace addToPhysicsWorld:world])
        [objectsToPlace removeObject:objectToPlace];
    else
        [self removeChild:objectToPlace cleanup:YES];
    objectToPlace = nil;
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(objectToPlace == nil)
        return;
    [self removeChild:objectToPlace cleanup:YES];
    objectToPlace = nil;
}

/*
//in case we ever want to actually use the accelerometer, I'm leaving this function in here. 
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( -accelY * 10, accelX * 10);
	
	world->SetGravity( gravity );
}
*/
 
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	delete world;
	world = NULL;
	
	delete m_debugDraw;

    [objectsToPlace release];

	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
