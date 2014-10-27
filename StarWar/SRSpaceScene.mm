//
//  SRSpaceScene.m
//  StarWar
//
//  Created by Shuangqing on 14-10-27.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"
#import "SRSpaceScene.h"
#import "SRConstants.h"
#import "SRSpaceLayer.h"
#import "SRGameControlLayer.h"
#import "SRControlLayer.h"

#import "SRGameOverBoardLayer.h"

@interface SRSpaceScene () <SRControlLayerDelegate, SRGameControlLayerDelegate>

@end

@implementation SRSpaceScene
{
    SRSpaceLayer *_spaceLayer;
    SRGameControlLayer *_gameControlLayer;
    SRControlLayer *_controlLayer;
    CCLayerColor *_darkBlueBackground;
}

- (void)onEnter
{
    [super onEnter];
    [self registerNotifications];

    _spaceLayer = [SRSpaceLayer node];
    [self addChild:_spaceLayer z:zSpaceLayer];

    _controlLayer = [SRControlLayer node];
    _controlLayer.delegate = self;
    [self addChild:_controlLayer z:zControlLayer];
    
    _gameControlLayer = [SRGameControlLayer node];
    _gameControlLayer.delegate = self;
    [self addChild:_gameControlLayer z:zGameControlLayer];
    
    _darkBlueBackground = [CCLayerColor layerWithColor:menuBackgroundColor];
    [self addChild:_darkBlueBackground z:zBackgroundLayer];
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipTouchPlane object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipTooFar object:nil];
}

#pragma mark - Handle Game Over

- (void)gameOver: (NSNotification *) notification
{
    [_spaceLayer stopSchedule];
    CCScene *newScene = [SRGameOverBoardLayer sceneWithFinalScore:0];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:newScene]];
}

#pragma mark - Control The Scene

- (void)pause
{
    [_spaceLayer pause];
    [_gameControlLayer changeGameStatusTo:SRStatusPause];
}

- (void)resume
{
    [_spaceLayer resume];
    [_gameControlLayer changeGameStatusTo:SRStatusRunning];
}

- (void)restart
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceScene node]]];
}

#pragma mark - SRControLayerDelegate Implement

- (void)controlLayerDidPressMinusButton:(SRControlLayer *)controlLayer
{
    [_spaceLayer spaceshipDecelerate];
}

- (void)controlLayerDidPressPlusButton:(SRControlLayer *)controlLayer
{
    [_spaceLayer spaceshipAccelerate];
}

#pragma mark - SRGameControlLayerDelegate Implement

- (void)gameControlLayerDidPressPauseButton:(SRGameControlLayer *)controlLayer
{
    [self pause];
}

- (void)gameControlLayerDidPressResumeButton:(SRGameControlLayer *)controlLayer
{
    [self resume];
}

- (void)gameControlLayerDidPressRestartButton:(SRGameControlLayer *)controlLayer
{
    [self restart];
}

@end
