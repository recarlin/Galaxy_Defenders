//
//  LeaderboardScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 12/11/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import "LeaderboardScene.h"

@implementation LeaderboardScene
- (id)init
{
    self = [super init];
    if (self != nil)
    {
//This grabs the leaderboard list from NSUserDefaults and displays them on the screen.
        CGSize size = [[CCDirector sharedDirector] winSize];
        LBText = @"";
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"LEADERBOARD" fontName:@"Verdana" fontSize:50];
        title.position = ccp(size.width/2, size.height - size.height/10);
        NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
        NSMutableArray *numbers = [UD mutableArrayValueForKey:@"Numbers"];
        NSMutableArray *names = [UD mutableArrayValueForKey:@"Names"];
        for (int i = 0; i < names.count; i++) {
            NSString *currentScore = [NSString stringWithFormat:@"%i. %@ - %@\n", (i+1), [names objectAtIndex:i], [[numbers objectAtIndex:i]stringValue]];
            LBText = [NSString stringWithFormat:@"%@%@", LBText, currentScore];
        }
        CCLabelTTF *leaderboard = [CCLabelTTF labelWithString:LBText fontName:@"Verdana" fontSize:36];
        leaderboard.anchorPoint = ccp(.5, 1);
        leaderboard.position = ccp(size.width/2, size.height - size.height/5);
        CCMenuItem *openMenu = [CCMenuItemImage itemWithNormalImage:@"MenuButton_Normal.png" selectedImage:@"MenuButton_Pressed.png" target:self selector:@selector(openMenu)];
        openMenu.scale = 3;
        CCMenu *menu = [CCMenu menuWithItems:openMenu, nil];
        menu.position = ccp(0, 0);
        if (size.width == 480 & size.height == 320)
        {
            leaderboard.fontSize = 18;
            openMenu.position = ccp(size.width/8, size.height/2);
            openMenu.scale = 2;
        } else
        {
            openMenu.position = ccp(size.width/2, size.height/10);
            openMenu.scale = 3;
        }
        [self addChild:title];
        [self addChild:leaderboard];
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
    LeaderboardScene *layer = [LeaderboardScene node];
    [scene addChild:layer];
	return scene;
}
- (void) openMenu
{
    //This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
@end

