//
//  SpriteLayer.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "SpriteLayer.h"
@implementation SpriteLayer
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        self.touchEnabled = TRUE;
        playerLasers = [[NSMutableArray alloc]init];
        enemyLasers = [[NSMutableArray alloc]init];
        enemies = [[NSMutableArray alloc]init];
        removeEnemies = [[NSMutableArray alloc] init];
        removeLasers = [[NSMutableArray alloc]init];
        enemiesLeft = 9;
        health = 100;
        gamePaused = FALSE;
        [[[CCDirector sharedDirector]view]setMultipleTouchEnabled:TRUE];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Explosion.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"PewPew.wav"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"SpaceMusic.mp3" loop:TRUE];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Explosion.plist"];
        explosionSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Explosion.png"];
        [self addChild:explosionSpriteSheet];
        CGSize size = [[CCDirector sharedDirector] winSize];
        if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
        {
            player = [CCSprite spriteWithFile:@"PlayerShip.PNG"];
            player.scale = .3;
            player.position = ccp(size.width/2, 100);
            [self addChild: player];
            for (int i = 1; i < 10; i++)
            {
                enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                enemy.scale = .3;
                enemy.rotation = 180;
                enemy.position = ccp(i * size.width/10, size.height - 30);
                [enemies addObject:enemy];
                [self addChild: enemy];
            }
            CCMenuItem *pause = [CCMenuItemImage itemWithNormalImage:@"Pause.png" selectedImage:@"Pause.png" target:self selector:@selector(changeState)];
            pause.scale = .2;
            pause.position = ccp(size.width - 20, size.height - 20);
            CCMenu *menu = [CCMenu menuWithItems:pause, nil];
            menu.position = ccp(0, 0);
            CCSprite *bar = [CCSprite spriteWithFile:@"HPBar.png"];
            hpBar = [CCProgressTimer progressWithSprite:bar];
            hpBar.type = kCCProgressTimerTypeBar;
            hpBar.scaleX = .65;
            hpBar.scaleY = .1;
            hpBar.position = ccp(size.width/2, 10);
            hpBar.percentage = 100;
            hpBar.midpoint = ccp(0, 1);
            hpBar.barChangeRate = ccp(1, 0);
            [self addChild:menu z:90];
            [self addChild:hpBar];
        } else
        {
            player = [CCSprite spriteWithFile:@"PlayerShip.PNG"];
            player.scale = .5;
            player.position = ccp(size.width/2, 100);
            [self addChild: player];
            for (int i = 1; i < 10; i++)
            {
                enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                enemy.scale = .5;
                enemy.rotation = 180;
                enemy.position = ccp(i * size.width/10, size.height - 60);
                [enemies addObject:enemy];
                [self addChild: enemy];
            }
            CCMenuItem *pause = [CCMenuItemImage itemWithNormalImage:@"Pause.png" selectedImage:@"Pause.png" target:self selector:@selector(changeState)];
            pause.scale = .25;
            pause.position = ccp(size.width - 30, size.height - 30);
            CCMenu *menu = [CCMenu menuWithItems:pause, nil];
            menu.position = ccp(0, 0);
            CCSprite *bar = [CCSprite spriteWithFile:@"HPBar.png"];
            hpBar = [CCProgressTimer progressWithSprite:bar];
            hpBar.type = kCCProgressTimerTypeBar;
            hpBar.scaleX = 1.3;
            hpBar.scaleY = .2;
            hpBar.position = ccp(size.width/2, 10);
            hpBar.percentage = 100;
            hpBar.midpoint = ccp(0, 1);
            hpBar.barChangeRate = ccp(1, 0);
            [self addChild:menu z:90];
            [self addChild:hpBar];
        }
        [self initButton];
        [self initJoystick];
        [self scheduleUpdate];
    }
    return self;
}
-(void)initJoystick
{
    SneakyJoystickSkinnedBase *joystickBase = [[SneakyJoystickSkinnedBase alloc] init];
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"Joystick.png"];
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"ButtonActive.png"];
    CGSize size = [[CCDirector sharedDirector]winSize];
    if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
    {
        joystickBase.backgroundSprite.scale = 2;
        joystickBase.thumbSprite.scale = .15;
        joystickBase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 50, 50)];
        joystickBase.joystick.joystickRadius = 40;
        joystickBase.position = ccp(60, 60);
    } else
    {
        joystickBase.backgroundSprite.scale = 4;
        joystickBase.thumbSprite.scale = .3;
        joystickBase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 100, 100)];
        joystickBase.joystick.joystickRadius = 80;
        joystickBase.position = ccp(120, 120);
    }
    [self addChild:joystickBase];
    leftJoystick = [joystickBase.joystick retain];
}
-(void)initButton
{
    SneakyButtonSkinnedBase *button = [[SneakyButtonSkinnedBase alloc]init];
    button.defaultSprite = [CCSprite spriteWithFile:@"ButtonActive.png"];
    button.activatedSprite = [CCSprite spriteWithFile:@"ButtonNormal.png"];
    button.pressSprite = [CCSprite spriteWithFile:@"ButtonNormal.png"];
    CGSize size = [[CCDirector sharedDirector]winSize];
    if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
    {
        button.defaultSprite.scale = .25;
        button.activatedSprite.scale = .25;
        button.pressSprite.scale = .25;
        button.button = [[SneakyButton alloc] initWithRect: CGRectMake(0, 0, 50, 50)];
        button.anchorPoint = ccp(0, 0);
        button.position = ccp(size.width - 40, 40);
        [self addChild:button];
    } else
    {
        button.defaultSprite.scale = .5;
        button.activatedSprite.scale = .5;
        button.pressSprite.scale = .5;
        button.button = [[SneakyButton alloc] initWithRect: CGRectMake(0, 0, 100, 100)];
        button.anchorPoint = ccp(0, 0);
        button.position = ccp(940, 90);
        [self addChild:button];
    }
    fireButton = [button.button retain];
}
-(void) update:(ccTime)deltaTime
{
    CGPoint velocity = ccpMult(leftJoystick.velocity, 500);
    CGPoint newPosition = ccp(player.position.x + velocity.x * deltaTime, player.position.y + velocity.y * deltaTime);
    CGSize size = [[CCDirector sharedDirector] winSize];
    if (newPosition.y>=size.height/2)
    {
        newPosition.y=size.height/2;
    }
    if (newPosition.y<0)
    {
        newPosition.y=0;
    }
    if (newPosition.x>size.width)
    {
        newPosition.x=newPosition.x-size.width;
    }
    if (newPosition.x<0)
    {
        newPosition.x=newPosition.x+size.width;
    }
    [player setPosition:newPosition];
    for (CCSprite *en in enemies)
    {
        if ((rand() % 100 + 1) == 50)
        {
            [[SimpleAudioEngine sharedEngine]playEffect:@"PewPew.wav"];
            [self shootLaserFrom:en.position to:ccp(en.position.x, 0) over:1.0f as:2];
        }
    }
    for (CCSprite *laser in playerLasers)
    {
        for (CCSprite *en in enemies)
        {
            if (CGRectIntersectsRect(en.boundingBox, laser.boundingBox))
            {
                CGPoint blowUpHere = ccp(en.position.x, en.position.y);
                [removeEnemies addObject:en];
                NSMutableArray *explosionFrames = [NSMutableArray array];
                for (int i=10001; i<=10090; i++) {
                    [explosionFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"explosion_%d.png",i]]];
                }
                CCSprite *boom = [CCSprite spriteWithSpriteFrameName:@"explosion_10001.png"];
                boom.position = blowUpHere;
                CCAnimation *explosionAnimation = [CCAnimation animationWithSpriteFrames:explosionFrames delay:0.1f];
                CCAction *explosion = [CCAnimate actionWithAnimation:explosionAnimation];
                [boom runAction:explosion];
                [[SimpleAudioEngine sharedEngine]playEffect:@"Explosion.mp3"];
                [explosionSpriteSheet addChild:boom];
            }
        }
        for (CCSprite *en in removeEnemies)
        {
            [enemies removeObject:en];
            [self removeChild:en  cleanup:YES];
            if (enemies.count <= 0)
            {
                [self unscheduleUpdate];
                
                [self finishGame:1];
            }
        }
    }
    for (CCSprite *laser in enemyLasers)
    {
        if (CGRectIntersectsRect(player.boundingBox, laser.boundingBox))
        {
            [removeLasers addObject:laser];
            [[SimpleAudioEngine sharedEngine]playEffect:@"Explosion.mp3"];
            health -= 25;
            [hpBar setPercentage:health];
        }
    }
    for (CCSprite *las in removeLasers)
    {
        [enemyLasers removeObject:las];
        [self removeChild:las  cleanup:YES];
    }
    if (fireButton.active == YES)
    {
        [[SimpleAudioEngine sharedEngine]playEffect:@"PewPew.wav"];
        [self shootLaserFrom:player.position to:ccp(player.position.x, 768) over:1.0f as:1];
    }
    if (health <= 0)
    {
        CGPoint blowUpHere = ccp(player.position.x, player.position.y);
        [self removeChild:player cleanup:TRUE];
        [self unscheduleUpdate];
        NSMutableArray *explosionFrames = [NSMutableArray array];
        for (int i=10001; i<=10090; i++)
        {
            [explosionFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"explosion_%d.png",i]]];
        }
        CCSprite *boom = [CCSprite spriteWithSpriteFrameName:@"explosion_10001.png"];
        boom.position = blowUpHere;
        CCAnimation *explosionAnimation = [CCAnimation animationWithSpriteFrames:explosionFrames delay:0.1f];
        CCAction *explosion = [CCAnimate actionWithAnimation:explosionAnimation];
        [boom runAction:explosion];
        [[SimpleAudioEngine sharedEngine]playEffect:@"Explosion.mp3"];
        [explosionSpriteSheet addChild:boom];
        [self finishGame:2];
    }
}
-(void)shootLaserFrom:(CGPoint)start to:(CGPoint)end over:(float)duration as:(int)laserType
{
    switch (laserType) {
        case 1:
        {
            CCSprite *laserPewPew = [CCSprite spriteWithFile:@"LaserGreen.png"];
            CGSize size = [[CCDirector sharedDirector] winSize];
            if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
            {
                laserPewPew.scale = .1;
            } else
            {
                laserPewPew.scale = .25;
            }
            laserPewPew.position = ccp(start.x, start.y + 15);
            [self addChild:laserPewPew];
            CCFiniteTimeAction *move = [CCMoveTo actionWithDuration:duration position:end];
            CCAction *clean = [CCCallBlockN actionWithBlock:^(CCNode *node)
                               {
                                   [playerLasers removeObject:node];
                                   [node removeFromParentAndCleanup:YES];
                               }];
            id action = [CCSequence actions:move, clean, nil];
            [playerLasers addObject:laserPewPew];
            [laserPewPew runAction:action];
        }
            break;
        case 2:
        {
            CCSprite *laserPewPew = [CCSprite spriteWithFile:@"LaserRed.png"];
            CGSize size = [[CCDirector sharedDirector] winSize];
            if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
            {
                laserPewPew.scale = .1;
            } else
            {
                laserPewPew.scale = .25;
            }
            laserPewPew.position = ccp(start.x, start.y - 15);
            [self addChild:laserPewPew];
            CCFiniteTimeAction *move = [CCMoveTo actionWithDuration:duration position:end];
            CCAction *clean = [CCCallBlockN actionWithBlock:^(CCNode *node)
                               {
                                   [enemyLasers removeObject:node];
                                   [node removeFromParentAndCleanup:YES];
                               }];
            id action = [CCSequence actions:move, clean, nil];
            [enemyLasers addObject:laserPewPew];
            [laserPewPew runAction:action];
        }
            break;
        default:
            break;
    }
}
-(void)changeState
{
    if (gamePaused == FALSE)
    {
        gamePaused = TRUE;
        [[CCDirector sharedDirector]pause];
    } else if (gamePaused == TRUE)
    {
        gamePaused = FALSE;
        [[CCDirector sharedDirector]resume];
    }
}
-(void)finishGame:(int)results
{
    switch (results)
    {
        case 1:
        {
            UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"VICTORY" message:@"You have destroyed all the enemy ships!" delegate:self cancelButtonTitle:@"Replay" otherButtonTitles:@"Menu", nil];
            [dialog show];
        }
            break;
        case 2:
        {
            UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"DEFEAT" message:@"The enemies have destroyed your ship!" delegate:self cancelButtonTitle:@"Replay" otherButtonTitles:@"Menu", nil];
            [dialog show];
        }
            break;
            
        default:
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            [[CCDirector sharedDirector]replaceScene:[GameScene scene]];
        }
            break;
        case 1:
        {
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:2 scene:[MenuScene scene]]];
        }
            break;
        default:
            break;
    }
}
@end
