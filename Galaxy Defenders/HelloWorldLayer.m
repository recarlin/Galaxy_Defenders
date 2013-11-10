//
//  HelloWorldLayer.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright Alonely 2013. All rights reserved.
//


#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
    BackgroundLayer *bg = [BackgroundLayer node];
    SpriteLayer *sprites = [SpriteLayer node];
    
    [scene addChild: bg z: -1];
    [scene addChild: sprites z: 10];
    
	return scene;
}

-(id) init
{
    self = [super init];
    if (self != nil) {
        
    }
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
