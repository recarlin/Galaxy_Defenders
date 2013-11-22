//
//  MenuScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "MenuScene.h"
@implementation MenuScene
- (id)init {
    self = [super init];
    if (self != nil)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *logo = [CCSprite spriteWithFile:@"Galaxy_Defenders_Logo.png"];
        logo.position = ccp(size.width/2, size.height - size.height/3);
        CCMenuItem *play = [CCMenuItemImage itemWithNormalImage:@"PlayButton_Normal.png" selectedImage:@"PlayButton_Pressed.png" target:self selector:@selector(startGame)];
        play.scale = 5;
        play.position = ccp(size.width/3, size.height/3);
        CCMenuItem *guide = [CCMenuItemImage itemWithNormalImage:@"GuideButton_Normal.png" selectedImage:@"GuideButton_Pressed.png" target:self selector:@selector(openGuide)];
        guide.scale = 5;
        guide.position = ccp(size.width - size.width/3, size.height/3);
        CCMenu *menu = [CCMenu menuWithItems:play, guide, nil];
        menu.position = ccp(0, 0);
        [self addChild:logo];
        [self addChild:menu z:10];
    }
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
+(CCScene *) scene {
	CCScene *scene = [CCScene node];
    MenuScene *layer = [MenuScene node];
    BackgroundLayer *bg = [BackgroundLayer node];
    [scene addChild:layer];
    [scene addChild: bg z: -1];
	return scene;
}
- (void) startGame
{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}
- (void) openGuide
{
    [[CCDirector sharedDirector] replaceScene:[GuideScene scene]];
}
@end
