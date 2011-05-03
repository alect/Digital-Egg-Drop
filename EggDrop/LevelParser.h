//
//  LevelParser.h
//  EggDrop
//
//  Created by Sarah Lehmann on 4/27/11.
//  Copyright Massachusetts Institute of Technology 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggBlock.h"

@interface LevelParser : NSObject <NSXMLParserDelegate>{
    
    NSMutableArray *objectDetails;
    
}

-(void)loadDataFromXML;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;

-(NSMutableArray*) getObjectDetails;

@end

