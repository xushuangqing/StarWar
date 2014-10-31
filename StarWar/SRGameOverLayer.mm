//
//  SRGameOverLayer.m
//  StarWar
//
//  Created by Shuangqing on 14-10-30.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRGameOverLayer.h"
#import "cocos2d.h"

@implementation SRGameOverLayer
{
    CCLayerColor *_mask;
    CCMenuItem *_restartButton;
    CCMenuItem *_mainMenuButton;
}

- (id)init
{
    if (self = [super init]) {
        [self initButton];
        [self initMask];
    }
    return self;
}

- (void)setFinalScore:(NSInteger)score
{
    
}

- (void)initMask
{
    _mask = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0)];
    [self addChild:_mask z:100];
    [_mask runAction:[CCFadeTo actionWithDuration:0.3 opacity:200]];
}

- (void)initButton
{
    CCMenuItemImage *gameOverLabel = [CCMenuItemImage itemWithNormalImage:@"labelGameOver@2x.png" selectedImage:@"labelGameOver@2x.png"];
    gameOverLabel.anchorPoint = ccp(0.5, 0.0);
    gameOverLabel.position = ccp([UIScreen mainScreen].bounds.size.height/2., 200);

    _mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"buttonMainMenuS@2x.png" selectedImage:@"buttonMainMenuS@2x.png" target:self selector:@selector(mainMenuButtonPressed:)];
    _mainMenuButton.anchorPoint = ccp(0.5, 0.5);
    _mainMenuButton.position = ccp([UIScreen mainScreen].bounds.size.height-40., 40.);
    
    _restartButton = [CCMenuItemImage itemWithNormalImage:@"buttonContinueS@2x.png" selectedImage:@"buttonContinueS@2x.png" target:self selector:@selector(restartButtonPressed:)];
    _restartButton.anchorPoint = ccp(0.5, 0.5);
    _restartButton.position = ccp([UIScreen mainScreen].bounds.size.height-120., 40.);
    
    CCMenu *controlMenu = [CCMenu menuWithItems:gameOverLabel, _mainMenuButton, _restartButton, nil];
    controlMenu.position = CGPointZero;
    controlMenu.opacity = 0;
    [self addChild:controlMenu z:200];
    
    [controlMenu runAction:[CCFadeIn actionWithDuration:0.3]];
}

- (void)mainMenuButtonPressed:(id)sender
{
    [self.delegate gameOverLayerDidPressMainMenuButton:self];
}

- (void)restartButtonPressed:(id)sender
{
    [self.delegate gameOverLayerDidPressRestartButton:self];
}

- (void)dealloc
{
    [self.delegate release];
    [super dealloc];
}

@end
