//
//  LaserManager.h
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/13/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CocosDenshion.h"

@interface LaserManager : NSObject
{
    NSMutableArray *lasersPewing;
    CCSprite *enemyPewPew;
    CCSprite *playerPewPew;
}
-(void)from:(CGPoint)start to:(CGPoint)end time:(float)time;

@end
