//
//  GameScene.h
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright Alonely 2013. All rights reserved.
//
#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "SpriteLayer.h"
#import "GameFinishedScene.h"
@interface GameScene : CCScene
{
    
}
+(CCScene *) scene:(int)level withScore:(int)score;
@end
