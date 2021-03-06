//
//  MenuScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "MenuScene.h"
@implementation MenuScene
+(CCScene *) scene
{
    //This is used to initiate the scene from another class.
	CCScene *scene = [CCScene node];
    MenuScene *layer = [MenuScene node];
    BackgroundLayer *bg = [BackgroundLayer node];
    [scene addChild:layer];
    [scene addChild: bg z: -1];
	return scene;
}
- (id)init
{
    self = [super init];
    if (self != nil)
    {
//This sets up the menu with the logo and adjusts the size based on the iOS device in use.
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"Feats"] == NULL)
        {
            NSArray *featNames = [NSArray arrayWithObjects:@"30seconds", @"5seconds", @"firstWin", @"win10", @"win25", @"win50", @"win100", nil];
            NSNumber *num = [NSNumber numberWithInt:0];
            NSArray *featCompleted = [NSArray arrayWithObjects:num, num, num, num, num, num, num, nil];
            NSDictionary *featList = [[NSDictionary alloc ]initWithObjects:featCompleted forKeys:featNames];
            [defaults setObject:featList forKey:@"Feats"];
            [defaults synchronize];
        }
        CGSize size = [[CCDirector sharedDirector]winSizeInPixels];
        CGSize size2 = [[CCDirector sharedDirector]winSize];
        CCSprite *logo = [CCSprite spriteWithFile:@"Galaxy_Defenders_Logo.png"];
        logo.position = ccp(size2.width/2, size2.height - size2.height/3);
        
        CCMenuItem *feats = [CCMenuItemImage itemWithNormalImage:@"FeatsButton_Normal.png" selectedImage:@"FeatsButton_Pressed.png" target:self selector:@selector(openFeats)];
        feats.position = ccp(size2.width - size2.width/5, size2.height/3);
        
        CCMenuItem *play = [CCMenuItemImage itemWithNormalImage:@"PlayButton_Normal.png" selectedImage:@"PlayButton_Pressed.png" target:self selector:@selector(startGame)];
        play.position = ccp(size2.width/2, size2.height/3);
        
        CCMenuItem *leaderboards = [CCMenuItemImage itemWithNormalImage:@"BoardsButton_Normal.png" selectedImage:@"BoardsButton_Pressed.png" target:self selector:@selector(openLeaderboards)];
        leaderboards.position = ccp(size2.width/5, size2.height/3);
        
        CCMenuItem *guide = [CCMenuItemImage itemWithNormalImage:@"GuideButton_Normal.png" selectedImage:@"GuideButton_Pressed.png" target:self selector:@selector(openGuide)];
        guide.position = ccp(size2.width/3, size2.height/8);
        
        CCMenuItem *credits = [CCMenuItemImage itemWithNormalImage:@"CreditsButton_Normal.png" selectedImage:@"CreditsButton_Pressed.png" target:self selector:@selector(openCredits)];
        credits.position = ccp(size2.width - size2.width/3, size2.height/8);
        
        CCMenu *menu = [CCMenu menuWithItems:play, guide, credits, leaderboards, feats, nil];
        menu.position = ccp(0, 0);
        if (size.width == 480 & size.height == 320){
            logo.scale = .2;
            play.scale = 1.5;
            guide.scale = 1;
            feats.scale = 1;
            credits.scale = 1;
            leaderboards.scale = 1;
        }else if (size.width == 960 & size.height == 640){
            logo.scale = .45;
            play.scale = 3;
            guide.scale = 2;
            feats.scale = 2;
            credits.scale = 2;
            leaderboards.scale = 2;
        }else if (size.width == 1136 & size.height == 640){
            logo.scale = .5;
            play.scale = 3;
            guide.scale = 2;
            feats.scale = 2;
            credits.scale = 2;
            leaderboards.scale = 2;
        }else if (size.width == 1024 & size.height == 768){
            logo.scale = .5;
            play.scale = 3;
            guide.scale = 2;
            feats.scale = 2;
            credits.scale = 2;
            leaderboards.scale = 2;
        }else if (size.width == 2048 & size.height == 1536){
            play.scale = 6.5;
            guide.scale = 5;
            feats.scale = 5;
            credits.scale = 5;
            leaderboards.scale = 5;
        }
        [self addChild:logo];
        [self addChild:menu z:10];
    }
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
- (void) startGame
{
//This opens the game scene.
    [[CCDirector sharedDirector] replaceScene:[GameScene scene:1 withScore:0]];
}
- (void) openGuide
{
//This opens up the guide scene.
    [[CCDirector sharedDirector] replaceScene:[GuideScene scene]];
}
- (void) openCredits
{
    //This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]];
}
- (void) openLeaderboards
{
    //This opens the leaderboard scene.
    [[CCDirector sharedDirector] replaceScene:[LeaderboardScene scene]];
}
- (void) openFeats
{
    //This opens the leaderboard scene.
    [[CCDirector sharedDirector] replaceScene:[FeatsScene scene]];
}
@end
