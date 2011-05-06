//
//  LevelParser.h
//  EggDrop
//
//  Created by Sarah Lehmann on 4/27/11.
//  Copyright Massachusetts Institute of Technology 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggBlock.h"
#import "PlaceableNode.h"
#import "EggDisaster.h"
#import "Egg.h"
#import "EggLevel.h"

@interface LevelParser : NSObject <NSXMLParserDelegate>{
    
    NSMutableArray *objectDetails;
    NSMutableArray *disasterDetails;
    NSMutableArray *initObjectDetails;
    Egg *myEgg;
    
}

-(void)loadDataFromXML:(NSString *)path;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;

-(NSMutableArray*) getObjectInit;
-(NSMutableArray*) getObjects;
-(NSMutableArray*) getDisasters;
-(Egg*) getEgg;

@end

