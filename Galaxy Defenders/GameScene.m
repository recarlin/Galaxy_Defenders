//
//  GameScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright Alonely 2013. All rights reserved.
//
#import "GameScene.h"
@implementation GameScene
+(CCScene *) scene:(int)level withScore:(int)score
{
	CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    BackgroundLayer *bg = [BackgroundLayer node];
    CCLayer *sprites = [SpriteLayer showSpritesOnLevel:level withScore:score];
    [scene addChild:layer];
    [scene addChild: bg z: -1];
    [scene addChild: sprites z: 10];
	return scene;
}
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        
    }
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
@end
