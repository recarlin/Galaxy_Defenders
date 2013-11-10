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
        bg = [CCSprite spriteWithFile:@"Background.png"];
        bg.scale = 1.25;
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
    }
    return self;
}

@end
