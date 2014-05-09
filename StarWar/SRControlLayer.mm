//
//  SRControlLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRControlLayer.h"
#import "SRConstants.h"
#import "SRSpaceLayer.h"
#import "IntroLayer.h"

@implementation SRControlLayer

-(id) init
{
    if (self = [super init]) {
        [self initButton];
        [self initGameOverLabel];
        _gameOverMenu.visible = NO;
    }
    return self;
}

-(void) initButton
{
    CCMenuItem *plusButton = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png" target:self selector:@selector(plusButtonPressed)];
    plusButton.position = ccp(60, 60);
    
    CCMenuItem *minusButton = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png" target:self selector:@selector(minusButtonPressed)];
    minusButton.position = ccp(400, 60);
    
    _controlMenu = [CCMenu menuWithItems:plusButton,minusButton, nil];
    _controlMenu.position = CGPointZero;
    [self addChild:_controlMenu];
}

-(void) initGameOverLabel
{
    CCMenuItemImage *gameOverImage = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png"];
    gameOverImage.position = ccp(200, 200);
    
    CCMenuItem *restartButton = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png" target:self selector:@selector(restartButtonPressed)];
    restartButton.position = ccp(200, 100);
    
    _gameOverMenu = [CCMenu menuWithItems:gameOverImage, restartButton, nil];
    _gameOverMenu.position = CGPointZero;
    [self addChild:_gameOverMenu];
}

-(void) plusButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNamePlusVelocity object:nil];
}

-(void) minusButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameMinusVelocity object:nil];
}

-(void) restartButtonPressed
{
    [[CCDirector sharedDirector] replaceScene:[SRSpaceLayer scene]];
}

@end
