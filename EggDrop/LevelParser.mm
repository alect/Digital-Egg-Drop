//
//  LevelParser.m
//  EggDrop
//
//  Created by Sarah Lehmann on 4/27/11.
//  Copyright Massachusetts Institute of Technology 2011. All rights reserved.
//

#import "LevelParser.h"

@implementation LevelParser

-(void)loadDataFromXML{
    
    NSString* path = [[NSBundle mainBundle] pathForResource: @"testxml" ofType: @"xml"];
    NSData* data = [NSData dataWithContentsOfFile: path];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: data];

    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if (!objectDetails){
        objectDetails = [[NSMutableArray arrayWithCapacity:5] retain];
    }
    
    if ([elementName isEqualToString:@"block"]) {
        
        int length = [[attributeDict valueForKey:@"length"] intValue];    
        int width = [[attributeDict valueForKey:@"width"] intValue];
        NSLog(@"Length: %i, Width: %i", length, width);
        [objectDetails addObject:[[[EggBlock alloc] initWithRect:CGRectMake(0, 0, length, width)] autorelease]];
    }
}

-(NSMutableArray*) getObjectDetails{
    return objectDetails;
}

@end

