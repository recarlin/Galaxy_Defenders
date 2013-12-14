//
//  SpriteLayer.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//
#import "SpriteLayer.h"
@implementation SpriteLayer
+(CCLayer *)showSpritesOnLevel:(int)level withScore:(int)score
{
    CCLayer *layer = [[self alloc]initOnLevel:level withScore:score];
	return  layer;
}
- (id)initOnLevel:(int)level withScore:(int)score
{
//Here we set up the joystick, the fire button, the enemies, the player, and other variables to run the game. It also preloads some sounds, loads the explosion sprite sheet, and initiates the HP bar and updater. This is where the game is set up, pretty much. Also, it sets the game up based off of the iOS device in use.
    self = [super init];
    if (self != nil)
    {
        self.touchEnabled = TRUE;
        time = 0;
        currentScore = score;
        currentLevel = level;
        playerLasers = [[NSMutableArray alloc]init];
        enemyLasers = [[NSMutableArray alloc]init];
        enemies = [[NSMutableArray alloc]init];
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
            player.rotation = 180;
            player.position = ccp(size.width/2, size.height/2);
            [self addChild: player];
            if (currentLevel == 1)
            {
                for (int i = 1; i < 10; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .3;
                    enemy.rotation = 180;
                    enemy.position = ccp(i * size.width/10, size.height - 30);
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
            }else if (currentLevel == 2)
            {
                for (int i = 1; i < 10; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .3;
                    enemy.rotation = 180;
                    enemy.position = ccp(i * size.width/10, size.height - 30);
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
                for (int i = 1; i < 4; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .3;
                    enemy.rotation = 270;
                    enemy.position = ccp((size.width - 30), (i * size.height/4));
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
            }else
            {
                for (int i = 1; i < 10; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .3;
                    enemy.rotation = 180;
                    enemy.position = ccp(i * size.width/10, size.height - 30);
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
                for (int i = 1; i < 4; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .3;
                    enemy.rotation = 270;
                    enemy.position = ccp((size.width - 30), (i * size.height/4));
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
                for (int i = 1; i < 5; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .3;
                    enemy.rotation = 90;
                    enemy.position = ccp((30), (i * size.height/5));
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
            }
            CCMenuItem *pause = [CCMenuItemImage itemWithNormalImage:@"Pause.png" selectedImage:@"Pause.png" target:self selector:@selector(changeState)];
            pause.scale = .2;
            pause.position = ccp(size.width - 20, size.height - 20);
            timer = [CCLabelTTF labelWithString:@"Time: 0" fontName:@"Verdana" fontSize:18];
            timer.position = ccp(size.width/2, size.height/10);
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
            [self addChild:timer];
            [self addChild:menu z:90];
            [self addChild:hpBar];
        } else
        {
            player = [CCSprite spriteWithFile:@"PlayerShip.PNG"];
            player.scale = .5;
            player.rotation = 180;
            player.position = ccp(size.width/2, size.height/2);
            [self addChild: player];
            if (currentLevel == 1)
            {
                for (int i = 1; i < 10; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .5;
                    enemy.rotation = 180;
                    enemy.position = ccp(i * size.width/10, size.height - 60);
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
            }else if (currentLevel == 2)
            {
                for (int i = 1; i < 10; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .5;
                    enemy.rotation = 180;
                    enemy.position = ccp(i * size.width/10, size.height - 60);
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
                for (int i = 1; i < 4; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .5;
                    enemy.rotation = 270;
                    enemy.position = ccp((size.width - 60), (i * size.height/4));
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
            }else
            {
                for (int i = 1; i < 10; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .5;
                    enemy.rotation = 180;
                    enemy.position = ccp(i * size.width/10, size.height - 60);
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
                for (int i = 1; i < 4; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .5;
                    enemy.rotation = 270;
                    enemy.position = ccp((size.width - 60), (i * size.height/4));
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
                for (int i = 1; i < 5; i++)
                {
                    enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
                    enemy.scale = .5;
                    enemy.rotation = 90;
                    enemy.position = ccp((60), (i * size.height/5));
                    [enemies addObject:enemy];
                    [self addChild: enemy];
                }
            }
            CCMenuItem *pause = [CCMenuItemImage itemWithNormalImage:@"Pause.png" selectedImage:@"Pause.png" target:self selector:@selector(changeState)];
            pause.scale = .25;
            pause.position = ccp(size.width - 30, size.height - 30);
            timer = [CCLabelTTF labelWithString:@"Time: 0" fontName:@"Verdana" fontSize:36];
            timer.position = ccp(size.width/2, size.height/10);
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
            [self addChild:timer];
            [self addChild:menu z:90];
            [self addChild:hpBar];
        }
        [self initJoysticks];
        [self scheduleUpdate];
        [self schedule:@selector(playerAutoShoot)interval:1.0];
        [self schedule:@selector(scoreTimer)interval:1.0];
    }
    return self;
}
-(void)initJoysticks
{
//This will set up the joystick based on the iOS device in use.
    SneakyJoystickSkinnedBase *LJoy = [[SneakyJoystickSkinnedBase alloc] init];
    SneakyJoystickSkinnedBase *RJoy = [[SneakyJoystickSkinnedBase alloc] init];
    LJoy.thumbSprite = [CCSprite spriteWithFile:@"ButtonActive.png"];
    RJoy.thumbSprite = [CCSprite spriteWithFile:@"ButtonActive.png"];
    CGSize size = [[CCDirector sharedDirector]winSize];
    if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
    {
        LJoy.thumbSprite.scale = .15;
        LJoy.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 30, 30)];
        LJoy.joystick.joystickRadius = 40;
        LJoy.position = ccp(60, 60);
        
        RJoy.thumbSprite.scale = .15;
        RJoy.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 30, 30)];
        RJoy.joystick.joystickRadius = 40;
        RJoy.position = ccp(size.width - 60, 60);
    } else
    {
        LJoy.thumbSprite.scale = .3;
        LJoy.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 60, 60)];
        LJoy.joystick.joystickRadius = 80;
        LJoy.position = ccp(120, 120);
        
        RJoy.thumbSprite.scale = .3;
        RJoy.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 60, 60)];
        RJoy.joystick.joystickRadius = 80;
        RJoy.position = ccp(size.width - 120, 120);
    }
    RJoy.joystick.autoCenter = FALSE;
    [self addChild:LJoy];
    [self addChild:RJoy];
    leftJoystick = [LJoy.joystick retain];
    rightJoystick = [RJoy.joystick retain];
}
-(void) update:(ccTime)deltaTime
{
//Here we have the main functionality of the game. Here we update the location of the player ship, we look for button presses, we initiate the firing of all lasers, collision detection with lasers and player/enemies, and we watch for victory/defeat conditions. All the action happens in this block of code. Some of the elements are based off of the iOS device in use.
    removePlayerLasers = [[NSMutableArray alloc]init];
    removeLasers = [[NSMutableArray alloc]init];
    removeEnemies = [[NSMutableArray alloc] init];
    CGPoint velocity = ccpMult(leftJoystick.velocity, 500);
    CGPoint newPosition = ccp(player.position.x + velocity.x * deltaTime, player.position.y + velocity.y * deltaTime);
    CGSize size = [[CCDirector sharedDirector] winSize];
    if (newPosition.y>=size.height - size.height/9)
    {
        newPosition.y=size.height - size.height/9;
    }
    if (newPosition.y<size.height/7)
    {
        newPosition.y=size.height/7;
    }
    if (newPosition.x>size.width - size.width/9)
    {
        newPosition.x=size.width - size.width/9;
    }
    if (newPosition.x<size.width/9)
    {
        newPosition.x=size.width/9;
    }
    [player setRotation:-rightJoystick.degrees + 90];
    [player setPosition:newPosition];
    for (CCSprite *en in enemies)
    {
        if ((rand() % 200 + 1) == 100)
        {
            [[SimpleAudioEngine sharedEngine]playEffect:@"PewPew.wav"];
            [self createLaser:2 at:en.position withRotation:en.rotation];
        }
    }
    for (CCSprite *laser in playerLasers)
    {
        float angle = -(laser.rotation - 90);
        float velocity = 10;
        float vx = cos(angle * M_PI / 180) * velocity;
        float vy = sin(angle * M_PI / 180) * velocity;
        CGPoint direction = ccp(vx,vy);
        laser.position = ccpAdd(laser.position, direction);
        if (!(CGRectIntersectsRect(CGRectMake(0, 0, size.width, size.height), laser.boundingBox)))
        {
            [removePlayerLasers addObject:laser];
        }
        removeEnemies = [[NSMutableArray alloc] init];
        for (CCSprite *en in enemies)
        {
            if (CGRectIntersectsRect(en.boundingBox, laser.boundingBox))
            {
                CGPoint blowUpHere = ccp(en.position.x, en.position.y);
                [removeEnemies addObject:en];
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
            }
        }
        for (CCSprite *en in removeEnemies)
        {
            [enemies removeObject:en];
            [self removeChild:en  cleanup:YES];
            if (enemies.count <= 0)
            {
                [self unscheduleUpdate];
                [self unschedule:@selector(playerAutoShoot)];
                [self unschedule:@selector(scoreTimer)];
                result = 1;
                [self performSelector:@selector(finishGame) withObject:Nil afterDelay:5.0f];
            }
        }
        [removeEnemies release];
    }
    for (CCSprite *las in removePlayerLasers)
    {
        [playerLasers removeObject:las];
        [self removeChild:las cleanup:YES];
    }
    [removePlayerLasers release];
    for (CCSprite *laser in enemyLasers)
    {
        float angle = -(laser.rotation - 90);
        float velocity = 10;
        float vx = cos(angle * M_PI / 180) * velocity;
        float vy = sin(angle * M_PI / 180) * velocity;
        CGPoint direction = ccp(vx,vy);
        laser.position = ccpAdd(laser.position, direction);
        if (CGRectIntersectsRect(player.boundingBox, laser.boundingBox))
        {
            [removeLasers addObject:laser];
            [[SimpleAudioEngine sharedEngine]playEffect:@"Explosion.mp3"];
            health -= 25;
            [hpBar setPercentage:health];
        }
        if (!(CGRectIntersectsRect(CGRectMake(0, 0, size.width, size.height), laser.boundingBox)))
        {
            [removeLasers addObject:laser];
        }
    }
    for (CCSprite *las in removeLasers)
    {
        [enemyLasers removeObject:las];
        [self removeChild:las cleanup:YES];
    }
    [removeLasers release];
    if (health <= 0)
    {
        [self unschedule:@selector(scoreTimer)];
        [self unschedule:@selector(playerAutoShoot)];
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
        result = 2;
        [self performSelector:@selector(finishGame) withObject:Nil afterDelay:5.0f];
    }
}
-(void)createLaser:(int)laserType at:(CGPoint)location withRotation:(float)angle
{
//This method will take the parameters, create a laser sprite based on what entity is shooting, and moves the laser along the path according to the angle given. This is based off of the device that is being used.
    switch (laserType)
    {
        case 1:
        {
            CCSprite *laserPewPew = [CCSprite spriteWithFile:@"LaserGreen.png"];
            laserPewPew.anchorPoint = ccp(laserPewPew.position.x/2, 0);
            laserPewPew.position = ccp(location.x, location.y);
            laserPewPew.rotation = angle;
            CGSize size = [[CCDirector sharedDirector] winSize];
            if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
            {
                laserPewPew.scale = .1;
            } else
            {
                laserPewPew.scale = .25;
            }
            [self addChild:laserPewPew];
            [playerLasers addObject:laserPewPew];
        }
            break;
        case 2:
        {
            CCSprite *laserPewPew = [CCSprite spriteWithFile:@"LaserRed.png"];
            laserPewPew.anchorPoint = ccp(laserPewPew.position.x/2, 0);
            laserPewPew.position = ccp(location.x, location.y);
            laserPewPew.rotation = angle;
            CGSize size = [[CCDirector sharedDirector] winSize];
            if (size.width == 480 & size.height == 320 || size.width == 568 & size.height == 320)
            {
                laserPewPew.scale = .1;
            } else
            {
                laserPewPew.scale = .25;
            }
            [self addChild:laserPewPew];
            [enemyLasers addObject:laserPewPew];
        }
            break;
        default:
            break;
    }
}
-(void)changeState
{
//This simply pauses or unpauses the game.
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
-(void)finishGame
{
//Here we take the game results and open the finishing scene with the parameter to make sure we are getting the correct result.
    currentScore = currentScore + ((100 - time) * (health/25 + 1));
    if (currentScore <= 0)
    {
        currentScore = 0;
    }
    switch (result)
    {
        case 1:
        {
            [[CCDirector sharedDirector]replaceScene:[GameFinishedScene scene:1 onLevel:currentLevel withScore:currentScore]];
        }
            break;
        case 2:
        {
            [[CCDirector sharedDirector]replaceScene:[GameFinishedScene scene:2 onLevel:currentLevel withScore:currentScore]];
        }
            break;
            
        default:
            break;
    }
}
-(void)playerAutoShoot
{
//This creates a laser for the player.
    [[SimpleAudioEngine sharedEngine]playEffect:@"PewPew.wav"];
    [self createLaser:1 at:player.position withRotation:player.rotation];
}
-(void)scoreTimer
{
    //This creates a laser for the player.
    time++;
    timer.string = [NSString stringWithFormat:@"Time: %i",time];
}
@end
