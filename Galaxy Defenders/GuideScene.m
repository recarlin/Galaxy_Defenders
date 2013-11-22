//
//  GuideScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "GuideScene.h"
@implementation GuideScene
- (id)init
{
    self = [super init];
    if (self != nil)
    {
//This will set up the guide scene with the image and buttons. It adjusts sizes based of of the iOS device being used.
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *guide = [CCSprite spriteWithFile:@"Guide.png"];
        guide.position = ccp(size.width/2, size.height/2);
        CCMenuItem *openMenu = [CCMenuItemImage itemWithNormalImage:@"MenuButton_Normal.png" selectedImage:@"MenuButton_Pressed.png" target:self selector:@selector(openMenu)];
        openMenu.position = ccp(size.width/3, size.height- size.height/3);
        CCMenuItem *play = [CCMenuItemImage itemWithNormalImage:@"PlayButton_Normal.png" selectedImage:@"PlayButton_Pressed.png" target:self selector:@selector(startGame)];
        play.position = ccp(size.width - size.width/3, size.height - size.height/3);
        CCMenu *menu = [CCMenu menuWithItems:openMenu, play, nil];
        menu.position = ccp(0, 0);
        if (size.width == 480 & size.height == 320)
        {
            guide.scale = .85;
            openMenu.scale = 2;
            play.scale = 2;
        } else
        {
            guide.scale = 2;
            openMenu.scale = 5;
            play.scale = 5;
        }
        [self addChild:guide];
        [self addChild:menu z:10];
    }
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
+(CCScene *) scene
{
//This is used to initiate the scene from another class.
	CCScene *scene = [CCScene node];
    GuideScene *layer = [GuideScene node];
    [scene addChild:layer];
	return scene;
}
- (void) openMenu
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
- (void) startGame
{
//This opens the game scene.
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}
@end
