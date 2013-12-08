//
//  GameFinishedScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "GameFinishedScene.h"
@implementation GameFinishedScene
- (id)initWithResults:(int)results onLevel:(int)level
{
//This will set up the correct sprite based on the results of the game. It also sets up the buttons to credits or the menu.
    self = [super init];
    if (self != nil)
    {
        currentLevel = level;
        CGSize size = [[CCDirector sharedDirector] winSize];
        switch (results)
        {
            case 1:
            {
                if (level == 3)
                {
                    secondButton = [CCMenuItemImage itemWithNormalImage:@"CreditsButton_Normal.png" selectedImage:@"CreditsButton_Pressed.png" target:self selector:@selector(openCredits)];
                }else
                {
                    secondButton = [CCMenuItemImage itemWithNormalImage:@"ContinueButton_Normal.png" selectedImage:@"ContinueButton_Pressed.png" target:self selector:@selector(nextLevel)];
                }
                resultsLabel = [CCSprite spriteWithFile:@"Victory.png"];
                secondButton.scale = 5;
                secondButton.position = ccp(size.width - size.width/3, size.height/3);
            }
                break;
            case 2:
            {
                resultsLabel = [CCSprite spriteWithFile:@"Defeat.png"];
                secondButton = [CCMenuItemImage itemWithNormalImage:@"CreditsButton_Normal.png" selectedImage:@"CreditsButton_Pressed.png" target:self selector:@selector(openCredits)];
                secondButton.scale = 5;
                secondButton.position = ccp(size.width - size.width/3, size.height/3);
            }
                break;
            default:
                break;
        }
        resultsLabel.scale = 5;
        resultsLabel.position = ccp(size.width/2, size.height - size.height/3);
        CCMenuItem *openMenu = [CCMenuItemImage itemWithNormalImage:@"MenuButton_Normal.png" selectedImage:@"MenuButton_Pressed.png" target:self selector:@selector(openMenu)];
        openMenu.scale = 5;
        openMenu.position = ccp(size.width/3, size.height/3);
        CCMenu *menu = [CCMenu menuWithItems:openMenu, secondButton, nil];
        menu.position = ccp(0, 0);
        if (size.width == 480 & size.height == 320)
        {
            resultsLabel.scale = 3;
            openMenu.scale = 2;
            secondButton.scale = 2;
        } else
        {
            resultsLabel.scale = 5;
            openMenu.scale = 5;
            secondButton.scale = 5;
        }
        [self addChild:resultsLabel];
        [self addChild:menu z:10];
    }
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
+(CCScene *) scene:(int)results onLevel:(int)level
{
//This is used to initiate the scene from another class, and also takes a parameter to control the victory/defeat sprites.
	CCScene *scene = [[self alloc] initWithResults:results onLevel:level];
    GameFinishedScene *layer = [GameFinishedScene node];
    BackgroundLayer *bg = [BackgroundLayer node];
    [scene addChild:layer];
    [scene addChild: bg z: -1];
	return  scene;
}
- (void) openMenu
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
- (void) nextLevel
{
    //This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[GameScene scene:(currentLevel + 1)]];
}
- (void) openCredits
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]];
}
@end