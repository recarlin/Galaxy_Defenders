//
//  BackgroundLayer.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

- (id)init {
    self = [super init];
    if (self != nil) {
        bg = [CCSprite spriteWithFile:@"Background.jpg"];
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        CGSize size = [[CCDirector sharedDirector] winSize];
        if (size.width == 480 & size.height == 320){
            bg.scale = 1.9;
        } else {
            bg.scale = 4.6;
        }
        [self addChild:bg];
    }
    return self;
}

@end
