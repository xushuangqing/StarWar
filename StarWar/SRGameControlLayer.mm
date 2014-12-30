//
//  SRGameControlLayer.m
//  StarWar
//
//  Created by Shuangqing on 14-10-26.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"
#import "SRGameControlLayer.h"

@implementation SRGameControlLayer
{
    CCLabelAtlas* _label;
    CCMenuItem *_pauseButton;
    CCMenuItem *_resumeButton;
    CCMenuItem *_restartButton;
    CCLayerColor *_mask;
}

- (id)init
{
    if (self = [super init]) {
        [SRGlobal setGameStatus:SRStatusRunning];
    }
    return self;
}

- (void)onEnter {
    [super onEnter];
    [self initButton];
    [self initMask];
}

- (void)initMask
{
    _mask = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0)];
    [self addChild:_mask z:100];
}

- (void)initButton
{
    _pauseButton = [CCMenuItemImage itemWithNormalImage:@"buttonPause@2x.png" selectedImage:@"buttonPause@2x.png" target:self selector:@selector(pauseButtonPressed:)];
    _pauseButton.anchorPoint = ccp(0, 0.5);
    _pauseButton.position = ccp(10., [UIScreen mainScreen].bounds.size.height-32.);
    
    _resumeButton = [CCMenuItemImage itemWithNormalImage:@"buttonResume@2x.png" selectedImage:@"buttonResume@2x.png" target:self selector:@selector(resumeButtonPressed:)];
    _resumeButton.anchorPoint = ccp(0.5, 0.5);
    _resumeButton.position = ccp([UIScreen mainScreen].bounds.size.width/3., [UIScreen mainScreen].bounds.size.height/2.);
    _resumeButton.opacity = 0;
    [_resumeButton setIsEnabled:NO];
    
    _restartButton = [CCMenuItemImage itemWithNormalImage:@"buttonContinue@2x.png" selectedImage:@"buttonContinue@2x.png" target:self selector:@selector(restartButtonPressed:)];
    _restartButton.anchorPoint = ccp(0.5, 0.5);
    _restartButton.position = ccp([UIScreen mainScreen].bounds.size.width*2./3., [UIScreen mainScreen].bounds.size.height/2.);
    _restartButton.opacity = 0;
    [_restartButton setIsEnabled:NO];
    
    CCMenu *controlMenu = [CCMenu menuWithItems:_pauseButton,_resumeButton,_restartButton, nil];
    controlMenu.position = CGPointZero;
    [self addChild:controlMenu z:200];
}

- (void)fadeToRunningMode
{
    [_mask runAction:[CCFadeOut actionWithDuration:0.3]];
    [_resumeButton runAction:[CCFadeTo actionWithDuration:0.3 opacity:0]];
    [_resumeButton setIsEnabled:NO];
    [_restartButton runAction:[CCFadeTo actionWithDuration:0.3 opacity:0]];
    [_restartButton setIsEnabled:NO];

    [_pauseButton runAction:[CCFadeTo actionWithDuration:0.3 opacity:255]];
    [_pauseButton setIsEnabled:YES];
}

- (void)fadeToPauseMode
{
    [_mask runAction:[CCFadeTo actionWithDuration:0.3 opacity:200]];
    [_resumeButton runAction:[CCFadeTo actionWithDuration:0.3 opacity:255]];
    [_resumeButton setIsEnabled:YES];
    [_restartButton runAction:[CCFadeTo actionWithDuration:0.3 opacity:255]];
    [_restartButton setIsEnabled:YES];
    
    [_pauseButton runAction:[CCFadeTo actionWithDuration:0.3 opacity:0]];
    [_pauseButton setIsEnabled:NO];
}

- (void)fadeToStopMode
{
    [_resumeButton runAction:[CCFadeTo actionWithDuration:0.5 opacity:0]];
    [_resumeButton setIsEnabled:NO];
    [_restartButton runAction:[CCFadeTo actionWithDuration:0.5 opacity:0]];
    [_restartButton setIsEnabled:NO];
    [_pauseButton runAction:[CCFadeTo actionWithDuration:0.5 opacity:0]];
    [_pauseButton setIsEnabled:NO];
}

- (void)updateStatus
{
    switch ([SRGlobal gameStatus]) {
        case SRStatusRunning:
            [self fadeToRunningMode];
            break;
        case SRStatusPause:
            [self fadeToPauseMode];
            break;
        case SRStatusStop:
            [self fadeToStopMode];
            break;
        default:
            break;
    }
}

- (void)changeGameStatusTo:(SRGameStatus)status
{
    [SRGlobal setGameStatus:status];
    [self updateStatus];
}


#pragma mark - Buttons

- (void)pauseButtonPressed:(id)sender
{
    [self.delegate gameControlLayerDidPressPauseButton:self];
}

- (void)resumeButtonPressed:(id)sender
{
    [self.delegate gameControlLayerDidPressResumeButton:self];
}

- (void)restartButtonPressed:(id)sender
{
    [self.delegate gameControlLayerDidPressRestartButton:self];
}

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
