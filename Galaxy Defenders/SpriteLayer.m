//
//  SpriteLayer.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright (c) 2013 Alonely. All rights reserved.
//

#import "SpriteLayer.h"

@implementation SpriteLayer

- (id)init {
    self = [super init];
    if (self != nil) {
        self.touchEnabled = TRUE;
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Explosion.mp3"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"SpaceMusic.mp3" loop:TRUE];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explosion.plist"];
        explosionSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"explosion.png"];
        [self addChild:explosionSpriteSheet];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        player = [CCSprite spriteWithFile:@"PlayerShip.PNG"];
        player.scale = .5;
        player.position = ccp(size.width/2, 100);
        [self addChild: player];
        
        enemy = [CCSprite spriteWithFile:@"EnemyShip.PNG"];
        enemy.scale = .5;
        enemy.rotation = 180;
        enemy.position = ccp(size.width/2, size.height - 100);
        [self addChild: enemy];
        
        [self initJoystick];
        [self scheduleUpdate];
    }
    return self;
}

-(void)initJoystick {
    SneakyJoystickSkinnedBase *joystickBase = [[SneakyJoystickSkinnedBase alloc] init];
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"Joystick.png"];
    joystickBase.backgroundSprite.scale = 4;
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"Joystick.png"];
    joystickBase.thumbSprite.scale = 2;
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 128, 128)];
    joystickBase.position = ccp(120, 120);
    [self addChild:joystickBase];
    leftJoystick = [joystickBase.joystick retain];
}

-(void) update:(ccTime)deltaTime {
    CGPoint velocity = ccpMult(leftJoystick.velocity, 500);
    CGPoint newPosition = ccp(player.position.x + velocity.x * deltaTime, player.position.y + velocity.y * deltaTime);
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    if (newPosition.y>=size.height) {
        newPosition.y=newPosition.y-size.height;
    }
    if (newPosition.y<0) {
        newPosition.y=newPosition.y+size.height;
    }
    
    if (newPosition.x>size.width) {
        newPosition.x=newPosition.x-size.width;
    }
    if (newPosition.x<0) {
        newPosition.x=newPosition.x+size.width;
    }
    
    [player setPosition:newPosition];
    
    if (CGRectIntersectsRect([player boundingBox], [enemy boundingBox])) {
        CGPoint blowUpHere = ccp(player.position.x, player.position.y);
        CGPoint blowUpHere2 = ccp(enemy.position.x, enemy.position.y);
        [player removeFromParentAndCleanup:TRUE];
        [enemy removeFromParentAndCleanup:TRUE];
        [self unscheduleUpdate];
        
        NSMutableArray *explosionFrames = [NSMutableArray array];
        for (int i=10001; i<=10090; i++) {
            [explosionFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"explosion_%d.png",i]]];
        }
        CCSprite *boom = [CCSprite spriteWithSpriteFrameName:@"explosion_10001.png"];
        boom.position = blowUpHere;
        CCSprite *boom2 = [CCSprite spriteWithSpriteFrameName:@"explosion_10001.png"];
        boom2.position = blowUpHere2;
        CCAnimation *explosionAnimation = [CCAnimation animationWithSpriteFrames:explosionFrames delay:0.1f];
        CCAction *explosion = [CCAnimate actionWithAnimation:explosionAnimation];
        [boom runAction:explosion];
        [boom2 runAction:explosion];
        [[SimpleAudioEngine sharedEngine]playEffect:@"Explosion.mp3"];
        [explosionSpriteSheet addChild:boom];
        [explosionSpriteSheet addChild:boom2];
    }
}

@end
