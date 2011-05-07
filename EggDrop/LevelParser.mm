//
//  LevelParser.m
//  EggDrop
//
//  Created by Sarah Lehmann on 4/27/11.
//  Copyright Massachusetts Institute of Technology 2011. All rights reserved.
//

#import "LevelParser.h"
#import "EggNail.h"
#import "EggHinge.h"
#import "EggCompoundBlock.h"
#import "WindDisaster.h"
#import "QuakeDisaster.h"

@implementation LevelParser

@synthesize level;

-(id) init
{
    if((self=[super init]))
    {
        initObjectDetails = [[NSMutableArray array] retain];
        objectDetails = [[NSMutableArray array] retain];
        disasterDetails = [[NSMutableArray array] retain];
        myEgg = nil;
    }
    return self;
}

-(void)loadDataFromXML:(NSString *)path{
    
    
    NSString* actualPath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    
    NSData* data = [NSData dataWithContentsOfFile: actualPath];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: data];
    
    //need to release our stuff first
    
    if(level != nil)
        [level release];
    initObjectDetails = [[NSMutableArray array] retain];
    objectDetails = [[NSMutableArray array] retain];
    disasterDetails = [[NSMutableArray array] retain];
    
    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
    
    level = [[EggLevel alloc] initWithObjectsInPlace:initObjectDetails andObjectsToPlace:objectDetails andDisasters:disasterDetails andEgg:myEgg];
    [initObjectDetails release];
    [objectDetails release];
    [disasterDetails release];
    [myEgg release];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"block"]) {
        
        int length = [[attributeDict valueForKey:@"length"] intValue];    
        int width = [[attributeDict valueForKey:@"width"] intValue];
        NSString* initStart = [attributeDict valueForKey:@"initAtStart"];
        
        NSLog(@"Length: %i, Width: %i, Exist at init:%@", length, width, initStart);
        
        if ([initStart isEqualToString:@"yes"]){
            int x = [[attributeDict valueForKey:@"posx"] intValue];
            int y = [[attributeDict valueForKey:@"posy"] intValue];
            [initObjectDetails addObject:[[[EggBlock alloc] initWithRect:CGRectMake(x, y, length, width)] autorelease]];
        }
        else{
            [objectDetails addObject:[[[EggBlock alloc] initWithRect:CGRectMake(0, 0, length, width)] autorelease]];
        }
    }
    
    else if ([elementName isEqualToString:@"nail"]) {
        [objectDetails addObject:[[[EggNail alloc] init] autorelease]];
        NSLog(@"Nail");
    }
    
    else if ([elementName isEqualToString:@"hinge"]) {
        [objectDetails addObject:[[[EggHinge alloc] init] autorelease]];
        NSLog(@"Hinge");
    }
    
    else if ([elementName isEqualToString:@"disaster"]) {
        NSString* type = [attributeDict valueForKey:@"type"];
        
        if ([type isEqualToString:@"quake"]){
            int strength = [[attributeDict valueForKey:@"strength"] intValue];
            int duration = [[attributeDict valueForKey:@"duration"] intValue];
            int frequency = [[attributeDict valueForKey:@"frequency"] intValue];
            int friction = [[attributeDict valueForKey:@"friction"] intValue];
            [disasterDetails addObject:[[[QuakeDisaster alloc] initWithDelay:3 andStrength:strength andFrequency:frequency andFriction:friction andDuration:duration] autorelease]];
            NSLog(@"Quake, strength: %i, duration: %i, frequency: %i, friction: %i", strength, duration, frequency, friction);
        }
        else if ([type isEqualToString:@"wind"]) {
            int strength = [[attributeDict valueForKey:@"strength"] intValue];
            int duration = [[attributeDict valueForKey:@"duration"] intValue];
            [disasterDetails addObject:[[[WindDisaster alloc] initWithDelay:3 andStrength:strength andDuration:duration] autorelease]];
            NSLog(@"Wind, strength: %i, duration: %i", strength, duration);
        }
    }
    
    else if ([elementName isEqualToString:@"egg"]) {
        int x = [[attributeDict valueForKey:@"posx"] intValue];
        int y = [[attributeDict valueForKey:@"posy"] intValue];
        myEgg = [[Egg alloc] initWithPos:ccp(x, y)];
        NSLog(@"Egg, posx: %i, posy: %i", x, y);
    }
    
}

-(void) dealloc
{
    if(level != nil)
        [level release];
    [super dealloc];
}

@end

