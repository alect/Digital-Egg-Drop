//
//  EggTutorial.h
//  EggDrop
//
//  Created by Sarah Lehmann on 5/9/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EggTutorial : NSObject {

    NSMutableArray* scenes;
    int scene_number;
    
}

@property(readonly) NSArray * scenes;

-(id) initWithScenes:(NSArray*)sceneArray;

@end
