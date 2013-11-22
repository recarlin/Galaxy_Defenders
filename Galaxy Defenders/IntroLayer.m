//
//  IntroLayer.m
//  Galaxy Defenders
//
//  Created by Russell Carlin on 11/9/13.
//  Copyright Alonely 2013. All rights reserved.
//
#import "IntroLayer.h"
@implementation IntroLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [IntroLayer node];
	[scene addChild: layer];
	return scene;
}
-(id) init
{
	if( (self=[super init]))
    {
//Here we set up the correct splash screen for the iOS device in use and set it as a sprite over the whole screen.
		CGSize size = [[CCDirector sharedDirector] winSizeInPixels];
        CGSize size2 = [[CCDirector sharedDirector]winSize];
		CCSprite *background;
		if (size.width == 480 & size.height == 320){
            background = [CCSprite spriteWithFile:@"Galaxy_Defenders_Splash_iPhone.png"];
            background.rotation = 90;
        } else if (size.width == 960 & size.height == 640){
            background = [CCSprite spriteWithFile:@"Galaxy_Defenders_Splash_iPhone@2x.png"];
            background.rotation = 90;
        } else if (size.width == 1136 & size.height == 640){
            background = [CCSprite spriteWithFile:@"Galaxy_Defenders_Splash_iPhone5.png"];
            background.rotation = 90;
        } else if (size.width == 1024 & size.height == 768){
            background = [CCSprite spriteWithFile:@"Galaxy_Defenders_Splash_iPad_LS.png"];
        } else if (size.width == 2048 & size.height == 1536){
            background = [CCSprite spriteWithFile:@"Galaxy_Defenders_Splash_iPad_LS@2x.png"];
        }
        background.position = ccp(size2.width/2, size2.height/2);
		[self addChild: background];
	}
	return self;
}
-(void) onEnter
{
//This will transition to the game menu after 2 seconds of this scene being open.
	[super onEnter];
    [self performSelector:@selector(transition) withObject:nil afterDelay:2];
}
-(void) transition
{
//Transitions to the menu scene.
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuScene scene]]];
}
@end
