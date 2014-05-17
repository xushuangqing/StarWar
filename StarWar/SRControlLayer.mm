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
#import "AppDelegate.h"
#import "SRScoreBoardLayer.h"

@implementation SRControlLayer

-(id) init
{
    if (self = [super init]) {
        [self initButton];
        //[self initGameOverLabel];
        //_gameOverMenu.visible = NO;
    }
    return self;
}

-(void) initButton
{
    CCMenuItem *plusButton = [CCMenuItemImage itemWithNormalImage:@"plus.png" selectedImage:@"plus.png" target:self selector:@selector(plusButtonPressed)];
    plusButton.anchorPoint = ccp(0, 0);
    plusButton.scale = 0.5;
    plusButton.position = ccp(0, 0);
    
    CCMenuItem *minusButton = [CCMenuItemImage itemWithNormalImage:@"minus.png" selectedImage:@"minus.png" target:self selector:@selector(minusButtonPressed)];
    minusButton.anchorPoint = ccp(1, 0);
    minusButton.scale = 0.5;
    minusButton.position = ccp([UIScreen mainScreen].bounds.size.height, 0);
    
    _controlMenu = [CCMenu menuWithItems:plusButton,minusButton, nil];
    _controlMenu.position = CGPointZero;
    [self addChild:_controlMenu];
}

/*-(void) initGameOverLabel
{
    CCMenuItemImage *gameOverImage = [CCMenuItemImage itemWithNormalImage:@"gameOver.png" selectedImage:@"gameOver.png"];
    gameOverImage.scale = 0.5;
    gameOverImage.position = ccp([UIScreen mainScreen].bounds.size.height/2, 200);
    
    CCMenuItem *restartButton = [CCMenuItemImage itemWithNormalImage:@"replay.png" selectedImage:@"replay.png" target:self selector:@selector(restartButtonPressed)];
    restartButton.scale = 0.5;
    restartButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 100);
    
    _gameOverMenu = [CCMenu menuWithItems:gameOverImage, restartButton, nil];
    _gameOverMenu.position = CGPointZero;
    [self addChild:_gameOverMenu];
}*/

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
