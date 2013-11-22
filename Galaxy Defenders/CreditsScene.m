//
//  CreditsScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/22/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import "CreditsScene.h"

@implementation CreditsScene
- (id)init
{
    self = [super init];
    if (self != nil)
    {
//This displays the credits as a label and sets up a button back to the menu.
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *credits = [CCLabelTTF labelWithString:@"Created by Alonely Studio\n\n\nProgramming\nRussell Carlin\n\nGraphics\nRussell Carlin\nWrathGames Studio\nSkorpio\nUlysses Grant\n\nSounds\nJosh Lizarraga\nMike Koenig" fontName:@"Verdana" fontSize:36];
        credits.position = ccp(size.width/2, size.height - size.height/3);
        CCMenuItem *openMenu = [CCMenuItemImage itemWithNormalImage:@"MenuButton_Normal.png" selectedImage:@"MenuButton_Pressed.png" target:self selector:@selector(openMenu)];
        openMenu.scale = 3;
        CCMenu *menu = [CCMenu menuWithItems:openMenu, nil];
        menu.position = ccp(0, 0);
        if (size.width == 480 & size.height == 320)
        {
            credits.fontSize = 18;
            openMenu.position = ccp(size.width/8, size.height/2);
            openMenu.scale = 2;
        } else
        {
            openMenu.position = ccp(size.width/2, size.height/10);
            openMenu.scale = 3;
        }
        [self addChild:credits];
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
    CreditsScene *layer = [CreditsScene node];
    [scene addChild:layer];
	return scene;
}
- (void) openMenu
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
@end
