//
//  GameFinishedScene.h
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/21/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "CCScene.h"
#import "cocos2d.h"
#import "MenuScene.h"
#import "CreditsScene.h"
@interface GameFinishedScene : CCScene
{
    CCSprite *resultsLabel;
    CCSprite *feat;
    CCMenuItem *secondButton;
    int currentLevel;
    int currentScore;
    NSString *currentPlayer;
    NSMutableDictionary *feats;
}
+(CCScene *) scene:(int)results onLevel:(int)level withScore:(int)score;
@end