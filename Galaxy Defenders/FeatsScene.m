//
//  FeatsScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 12/19/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import "FeatsScene.h"

@implementation FeatsScene
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
               CCLabelTTF *title = [CCLabelTTF labelWithString:@"FEATS" fontName:@"Verdana" fontSize:50];
        title.position = ccp(size.width/2, size.height - size.height/11);
        NSArray *featNames = [NSArray arrayWithObjects:@"30seconds", @"5seconds", @"firstwin", @"win10", @"win25", @"win50", @"win100", Nil];
        NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
        NSDictionary *values = [UD objectForKey:@"Feats"];
        for (int i = 1; i < 4; i++)
        {
            if ([[values objectForKey:[featNames objectAtIndex:(i - 1)]]intValue] == 1)
            {
                currentFeat = [NSString stringWithFormat:@"%@.png", [featNames objectAtIndex:(i - 1)]];
            } else
            {
                currentFeat = [NSString stringWithFormat:@"%@_Nope.png", [featNames objectAtIndex:(i - 1)]];
            }
            CCSprite *sprite = [CCSprite spriteWithFile:currentFeat];
            if (size.width == 480 & size.height == 320)
            {
                title.fontSize = 20;
                sprite.scale = 2;
                sprite.position = ccp(size.width/4, size.height - (30 + (i * 50)));
            } else if (size.width == 1024 & size.height == 768)
            {
                sprite.scale = 4;
                sprite.position = ccp(size.width/4, size.height - (100 + (i * 100)));
            } else
            {
                title.fontSize = 20;
                sprite.scale = 3;
                sprite.position = ccp(size.width/4, size.height - (75 + (i * 75)));
            }
            [self addChild:sprite];
        }
        for (int i = 4; i < 8; i++)
        {
            if ([[values objectForKey:[featNames objectAtIndex:(i - 1)]]intValue] == 1)
            {
                currentFeat = [NSString stringWithFormat:@"%@.png", [featNames objectAtIndex:(i - 1)]];
            } else
            {
                currentFeat = [NSString stringWithFormat:@"%@_Nope.png", [featNames objectAtIndex:(i - 1)]];
            }
            CCSprite *sprite = [CCSprite spriteWithFile:currentFeat];
            if (size.width == 480 & size.height == 320)
            {
                sprite.scale = 2;
                sprite.position = ccp(size.width - size.width/4, size.height - (30 + ((i - 3) * 50)));
            } else if (size.width == 1024 & size.height == 768)
            {
                sprite.scale = 4;
                sprite.position = ccp(size.width - size.width/4, size.height - (100 + ((i - 3) * 100)));
            } else
            {
                sprite.scale = 3;
                sprite.position = ccp(size.width - size.width/4, size.height - (75 + ((i - 3) * 75)));
            }
            [self addChild:sprite];
        }
        CCMenuItem *openMenu = [CCMenuItemImage itemWithNormalImage:@"MenuButton_Normal.png" selectedImage:@"MenuButton_Pressed.png" target:self selector:@selector(openMenu)];
        openMenu.scale = 3;
        CCMenu *menu = [CCMenu menuWithItems:openMenu, nil];
        menu.position = ccp(0, 0);
        if (size.width == 480 & size.height == 320)
        {
            openMenu.position = ccp(size.width/2, size.height/10);
            openMenu.scale = 2;
        } else
        {
            openMenu.position = ccp(size.width/2, size.height/10);
            openMenu.scale = 3;
        }
        [self addChild:title];
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
    FeatsScene *layer = [FeatsScene node];
    [scene addChild:layer];
	return scene;
}
- (void) openMenu
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
@end
