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
#import "StrawEggBlock.h"
#import "BrickEggBlock.h"
#import "CushionEggBlock.h"
#import "WindDisaster.h"
#import "QuakeDisaster.h"
#import "MeteorDisaster.h"
#import "CloudBlockDisaster.h"

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
        cloudDisaster = nil;
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
    cloudDisaster = nil;
    myEgg = nil;
    
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
        
        float length = [[attributeDict valueForKey:@"length"] floatValue];    
        float width = [[attributeDict valueForKey:@"width"] floatValue];
        float x = 0;
        float y = 0;
        NSString *type = @"wood";
        NSString* initStart = [attributeDict valueForKey:@"initAtStart"];
        BOOL initAtStart = NO;
        NSLog(@"Length: %f, Width: %f, Exist at init:%@", length, width, initStart);
        
        //now handle special types of blocks
        if([attributeDict valueForKey:@"type"])
        {
            type = [attributeDict valueForKey:@"type"];
        }
        if ([initStart isEqualToString:@"yes"]){
            initAtStart = YES;
            x = [[attributeDict valueForKey:@"posx"] floatValue];
            y = [[attributeDict valueForKey:@"posy"] floatValue];
        }
        
        EggBlock *blockToAdd;
        if([type isEqualToString:@"straw"])
        {
            NSLog(@"STRAW!!");
            blockToAdd = [[[StrawEggBlock alloc] initWithRect:CGRectMake(x, y, length, width)] autorelease];
        }
        else if([type isEqualToString:@"brick"])
        {
            blockToAdd = [[[BrickEggBlock alloc] initWithRect:CGRectMake(x, y, length, width)] autorelease];
        }
        else if([type isEqualToString:@"cushion"])
        {
            blockToAdd = [[[CushionEggBlock alloc] initWithRect:CGRectMake(x, y, length, width)] autorelease];
        }
        else if([type isEqualToString:@"cloud"])
        {
            blockToAdd = [[[CloudEggBlock alloc] initWithRect:CGRectMake(x, y, length, width)] autorelease];
            if(cloudDisaster == nil)
            {
                cloudDisaster = [[[CloudBlockDisaster alloc] initWithDelay:3 andDuration:4] autorelease];
                [disasterDetails addObject:cloudDisaster];
            }
        }
        else{
            blockToAdd = [[[EggBlock alloc] initWithRect:CGRectMake(x, y, length, width)] autorelease];
        }
        if(initAtStart)
            [initObjectDetails addObject:blockToAdd];
        else
            [objectDetails addObject:blockToAdd];
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
        float delay = 3;
        if([attributeDict valueForKey:@"delay"])
            delay = [[attributeDict valueForKey:@"delay"] floatValue];
        if ([type isEqualToString:@"quake"]){
            float strength = [[attributeDict valueForKey:@"strength"] floatValue];
            float duration = [[attributeDict valueForKey:@"duration"] floatValue];
            float frequency = [[attributeDict valueForKey:@"frequency"] floatValue];
            float friction = [[attributeDict valueForKey:@"friction"] floatValue];
            
            [disasterDetails addObject:[[[QuakeDisaster alloc] initWithDelay:delay andStrength:strength andFrequency:frequency andFriction:friction andDuration:duration] autorelease]];
            NSLog(@"Quake, strength: %f, duration: %f, frequency: %f, friction: %f", strength, duration, frequency, friction);
        }
        else if ([type isEqualToString:@"wind"]) {
            float strength = [[attributeDict valueForKey:@"strength"] floatValue];
            float duration = [[attributeDict valueForKey:@"duration"] floatValue];
            [disasterDetails addObject:[[[WindDisaster alloc] initWithDelay:delay andStrength:strength andDuration:duration] autorelease]];
            NSLog(@"Wind, strength: %f, duration: %f", strength, duration);
        }
        else if([type isEqualToString:@"meteor"]) {
            float duration = [[attributeDict valueForKey:@"duration"] floatValue];
            [disasterDetails addObject:[[[MeteorDisaster alloc] initWithDelay:delay andDuration:duration] autorelease]];
            NSLog(@"Meteor, duration: %f", duration);
        }
    }
    
    else if ([elementName isEqualToString:@"egg"]) {
        float x = [[attributeDict valueForKey:@"posx"] floatValue];
        float y = [[attributeDict valueForKey:@"posy"] floatValue];
        myEgg = [[Egg alloc] initWithPos:ccp(x, y)];
        NSLog(@"Egg, posx: %f, posy: %f", x, y);
    }
    
}

-(void) dealloc
{
    if(level != nil)
        [level release];
    [super dealloc];
}

@end

