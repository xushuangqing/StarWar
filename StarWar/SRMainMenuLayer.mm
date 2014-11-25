//
//  SRMainMenuLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRMainMenuLayer.h"
#import "SRSpaceLayer.h"
#import "SRConstants.h"
#import "SRSpaceScene.h"
#import "cocos2d.h"
#import "SRGlobal.h"

@implementation SRMainMenuLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SRMainMenuLayer *layer = [SRMainMenuLayer node];
	[scene addChild:layer];
	return scene;
}

- (void)onEnter
{
    [SRGlobal setGameStatus:SRStatusStop];
    [super onEnter];
    [self initBackground];
    [self initMenu];
}

- (void)initBackground
{
    [self initBackgroundColor];
    [self initBackgroundEarth];
}

- (void)initBackgroundColor
{
    CCLayerColor *darkBlue = [CCLayerColor layerWithColor:menuBackgroundColor];
    [self addChild:darkBlue z:zBackgroundColor tag:kTagBackgroundColor];
}

- (void)initBackgroundEarth
{
    CCSprite *backgroundEarth = [CCSprite spriteWithFile:@"backgroundEarth@2x.png"];
    backgroundEarth.anchorPoint = ccp(0, 0);
    backgroundEarth.position = ccp(0, 0);
    [self addChild:backgroundEarth z:zBackgroundEarth tag:kTagBackgroundEarth];
}

- (void)initMenu
{
    CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"buttonPlay@2x.png" selectedImage:@"buttonPlay@2x.png" target:self selector:@selector(startButtonPressed:)];
    startButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 210);
    
    CCMenu* menu = [CCMenu menuWithItems:startButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zMenu tag:kTagMenu];
}

- (void)startButtonPressed:(id)sender
{
    [self buttonPressed:sender];
    NSLog(@"startButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceScene node]]];
}

- (void)buttonPressed:(id)sender
{
    CCMenuItem *menuItem = (CCMenuItem*) sender;
    menuItem.position = ccp(menuItem.position.x-2, menuItem.position.y-2);
}


@end
