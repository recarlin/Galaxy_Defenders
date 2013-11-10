//
//  SpriteLayer.h
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"

#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

@interface SpriteLayer : CCLayer
{
    CCSprite *player;
    CCSprite *enemy;
    CCSpriteBatchNode *explosionSpriteSheet;
    SneakyJoystick *leftJoystick;
}

@end
