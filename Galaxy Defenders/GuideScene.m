//
//  GuideScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "GuideScene.h"
@implementation GuideScene
- (id)init {
    self = [super init];
    if (self != nil)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *guide = [CCSprite spriteWithFile:@"Guide.png"];
        guide.scale = 2;
        guide.position = ccp(size.width/2, size.height/2);
        CCMenuItem *openMenu = [CCMenuItemImage itemWithNormalImage:@"MenuButton_Normal.png" selectedImage:@"MenuButton_Pressed.png" target:self selector:@selector(openMenu)];
        openMenu.scale = 5;
        openMenu.position = ccp(size.width/3, size.height- size.height/3);
        CCMenuItem *play = [CCMenuItemImage itemWithNormalImage:@"PlayButton_Normal.png" selectedImage:@"PlayButton_Pressed.png" target:self selector:@selector(startGame)];
        play.scale = 5;
        play.position = ccp(size.width - size.width/3, size.height - size.height/3);
        CCMenu *menu = [CCMenu menuWithItems:openMenu, play, nil];
        menu.position = ccp(0, 0);
        [self addChild:guide];
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
    GuideScene *layer = [GuideScene node];
    [scene addChild:layer];
	return scene;
}
- (void) openMenu
{
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
- (void) startGame
{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}
@end
