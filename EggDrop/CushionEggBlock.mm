//
//  CushionEggBlock.m
//  EggDrop
//
//  Created by Alec Thomson on 5/7/11.
//  Copyright 2011 Massachusetts Institute of Technology. All rights reserved.
//

#import "CushionEggBlock.h"


@implementation CushionEggBlock

-(id) initWithRect:(CGRect)blockRect
{
    if((self = [super initWithRect:blockRect]))
    {
        blockType = @"cushion";
        density = 0.5;
    }
    return self;
}

-(void) loadGraphics:(CGRect)blockRect
{
    mySprite = [CCSprite spriteWithFile:@"cushiontexture.png"];
    mySprite.position = ccp(blockRect.origin.x, blockRect.origin.y);
    width = blockRect.size.width;
    height = blockRect.size.height;
    mySprite.scaleX = width/mySprite.contentSize.width;
    mySprite.scaleY = height/mySprite.contentSize.height;
    
    [self addChild:mySprite];
    desiredZ = 0;
}

-(id)copyWithZone:(NSZone*)zone
{
    CushionEggBlock *clone = [[CushionEggBlock allocWithZone:zone] initWithRect:CGRectMake(self.position.x, self.position.y, self.width, self.height)];
    return clone;
}


@end
