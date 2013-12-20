//
//  GameFinishedScene.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "GameFinishedScene.h"
@implementation GameFinishedScene
+(CCScene *) scene:(int)results onLevel:(int)level withScore:(int)score
{
    //This is used to initiate the scene from another class, and also takes a parameter to control the victory/defeat sprites.
	CCScene *scene = [[self alloc] initWithResults:results onLevel:level withScore:score];
    GameFinishedScene *layer = [GameFinishedScene node];
    BackgroundLayer *bg = [BackgroundLayer node];
    [scene addChild:layer];
    [scene addChild: bg z: -1];
	return  scene;
}
- (id)initWithResults:(int)results onLevel:(int)level withScore:(int)score
{
//This will set up the correct sprite based on the results of the game. It will also initiate the next level, check the score against the leaderboards, and ask for a name if you scored higher. It also sets up the buttons to credits or the menu.
    self = [super init];
    if (self != nil)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"Names"] == NULL)
        {
            [defaults setObject:nil forKey:@"Names"];
            [defaults setObject:nil forKey:@"Numbers"];
        }
        currentLevel = level;
        currentScore = score;
        currentPlayer = @"Default Name";
        CGSize size = [[CCDirector sharedDirector] winSize];
        NSString *scoreString = [NSString stringWithFormat:@"Score: %i", score];
        CCLabelTTF *userScore = [CCLabelTTF labelWithString:scoreString fontName:@"Verdana" fontSize:36];
        userScore.position = ccp(size.width/2, size.height/10);
        switch (results)
        {
            case 1:
            {
                if (level == 3)
                {
                    if ([defaults objectForKey:@"GamesWon"] == NULL)
                    {
                        [defaults setObject:[NSNumber numberWithInt:1] forKey:@"GamesWon"];
                        [self markFeatAsDone:5];
                    } else
                    {
                        int won = [[defaults objectForKey:@"GamesWon"]intValue];
                        [defaults setObject:[NSNumber numberWithInt:won + 1] forKey:@"GamesWon"];
                        [defaults synchronize];
                        int gamesWon = [[defaults objectForKey:@"GamesWon"]intValue];
                        if (gamesWon == 10)
                        {
                            if (gamesWon == 25)
                            {
                                if (gamesWon == 50)
                                {
                                    if (gamesWon == 100)
                                    {
                                        [self markFeatAsDone:4];
                                    }
                                    [self markFeatAsDone:3];
                                }
                                [self markFeatAsDone:2];
                            }
                            [self markFeatAsDone:1];
                        }
                    }
                    secondButton = [CCMenuItemImage itemWithNormalImage:@"CreditsButton_Normal.png" selectedImage:@"CreditsButton_Pressed.png" target:self selector:@selector(openCredits)];
                    NSArray *numbers = [defaults arrayForKey:@"Numbers"];
                    if (numbers.count < 10 || currentScore > [[numbers objectAtIndex:9]integerValue])
                    {
                        [self setName];
                    }
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
        [self addChild:userScore];
        [self addChild:resultsLabel];
        [self addChild:menu z:10];
    }
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
- (void) openMenu
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];
}
- (void) nextLevel
{
    //This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[GameScene scene:(currentLevel + 1) withScore:currentScore]];
}
- (void) openCredits
{
//This opens the menu scene.
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]];
}
- (void) setName
{
    UIAlertView *nameDialog = [[UIAlertView alloc] initWithTitle:@"You made the leaderboard!" message:@"Please insert your name below." delegate:self cancelButtonTitle:@"Finished" otherButtonTitles:nil];
    nameDialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [nameDialog show];
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    UITextField *textField = [alertView textFieldAtIndex:0];
    currentPlayer = [textField text];
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    NSMutableArray *numbers = [UD mutableArrayValueForKey:@"Numbers"];
    NSMutableArray *names = [UD mutableArrayValueForKey:@"Names"];
    [numbers addObject:[NSNumber numberWithInt:currentScore]];
    NSSortDescriptor *desc = [[NSSortDescriptor alloc]initWithKey:@"self" ascending:FALSE];
    NSArray *sorted = [numbers sortedArrayUsingDescriptors:[NSArray arrayWithObject:desc]];
    numbers = [sorted mutableCopy];
    while (numbers.count > 10) {
        [numbers removeLastObject];
    }
    int position = [sorted indexOfObject:[NSNumber numberWithInt:currentScore]];
    [names insertObject:currentPlayer atIndex:position];
    while (names.count > 10) {
        [names removeLastObject];
    }
    [UD setObject:names forKey:@"Names"];
    [UD setObject:numbers forKey:@"Numbers"];
    [UD synchronize];
}
-(void)markFeatAsDone:(int)featID
{
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    feats = [UD objectForKey:@"Feats"];
    switch (featID) {
        case 1:
        {
            [feats setValue:[NSNumber numberWithInt:1] forKey:@"win10"];
            feat = [CCSprite spriteWithFile:@"win10.png"];
        }
            break;
        case 2:
        {
            [feats setValue:[NSNumber numberWithInt:1] forKey:@"win25"];
            feat = [CCSprite spriteWithFile:@"win25.png"];
        }
            break;
        case 3:
        {
            [feats setValue:[NSNumber numberWithInt:1] forKey:@"win50"];
            feat = [CCSprite spriteWithFile:@"win50.png"];
        }
            break;
        case 4:
        {
            [feats setValue:[NSNumber numberWithInt:1] forKey:@"win100"];
            feat = [CCSprite spriteWithFile:@"win100.png"];
        }
            break;
        case 5:
        {
            [feats setValue:[NSNumber numberWithInt:1] forKey:@"firstwin"];
            feat = [CCSprite spriteWithFile:@"firstwin.png"];
        }
            break;
        default:
        {
            
        }
            break;
    }
    [UD setObject:feats forKey:@"Feats"];
    [UD synchronize];
    CGSize size = [[CCDirector sharedDirector] winSize];
    feat.scale = 4;
    feat.position = ccp(size.width - size.width/4, size.height/9);
    feat.opacity = 0;
    [self addChild:feat];
    id fadeIn = [CCFadeIn actionWithDuration:.5];
    id wait = [CCDelayTime actionWithDuration:2.0];
    id fadeOut = [CCFadeOut actionWithDuration:.5];
    id removeSprite = [CCCallFuncND actionWithTarget:self selector:@selector(remove:) data:feat];
    [feat runAction:[CCSequence actions:fadeIn, wait, fadeOut, removeSprite, nil]];
}
-(void)remove:(CCSprite*)sprite
{
    [self removeChild:sprite cleanup:YES];
}
@end