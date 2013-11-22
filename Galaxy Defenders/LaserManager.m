//
//  LaserManager.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/13/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "LaserManager.h"
@implementation LaserManager
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        lasersPewing = [[NSMutableArray alloc]init];
        enemyPewPew = [CCSprite spriteWithFile:@"LaserRed.png"];
        playerPewPew = [CCSprite spriteWithFile:@"LaserGreen.png"];
    }
    return self;
}
-(void)from:(CGPoint)start to:(CGPoint)end time:(float)time
{
    CCSprite *laserPewPew = playerPewPew;
    laserPewPew.position = start;
    id move = [CCMoveTo actionWithDuration:time position:end];
    [laserPewPew runAction:move];
}
@end