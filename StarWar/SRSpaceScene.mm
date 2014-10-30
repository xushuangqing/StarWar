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
#import "SRGameOverLayer.h"
#import "SRGameOverBoardLayer.h"

@interface SRSpaceScene () <SRControlLayerDelegate, SRGameControlLayerDelegate, SRGameOverLayerProtocal>

@end

@implementation SRSpaceScene
{
    SRSpaceLayer *_spaceLayer;
    SRGameControlLayer *_gameControlLayer;
    SRControlLayer *_controlLayer;
    CCLayerColor *_darkBlueBackground;
    SRGameOverLayer *_gameOverLayer;
}

- (void)onEnter
{
    [super onEnter];

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

- (void)showGameOverLayer
{
    if (!_gameOverLayer) {
        _gameOverLayer = [SRGameOverLayer node];
        _gameOverLayer.delegate = self;
        [self addChild:_gameOverLayer z:zGameOverLayer];
    }
}

#pragma mark - Control The Scene

- (void)pause
{
    [_spaceLayer pause];
    [_controlLayer setMenuEnabled:NO];
    [_gameControlLayer changeGameStatusTo:SRStatusPause];
}

- (void)resume
{
    [_spaceLayer resume];
    [_controlLayer setMenuEnabled:YES];
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

- (void)controlLayer:(SRControlLayer *)controlLayer gameOverWithFinalScore:(NSInteger)score
{
    [_spaceLayer stopSchedule];
    [self showGameOverLayer];
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

#pragma mark - SRGameOverLayerDelegate Implement

- (void)gameOverLayerDidPressMainMenuButton:(SRGameOverLayer *)layer
{
    
}

- (void)gameOverLayerDidPressRestartButton:(SRGameOverLayer *)layer
{
    [self restart];
}

@end
