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
#import "SRGameOverBoardLayer.h"

@interface SRControlLayer ()
{
    CCLabelTTF *_label;
}

@end

@implementation SRControlLayer

-(id) init
{
    if (self = [super init]) {
        _score = 0;
        [self registerNotifications];
        [self initButton];
        [self initScoreBoard];
    }
    return self;
}

-(void) registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scorePlus:) name:NSNotificationNameScorePlus object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipTouchPlane object:nil];
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
    
    CCMenu *controlMenu = [CCMenu menuWithItems:plusButton,minusButton, nil];
    controlMenu.position = CGPointZero;
    [self addChild:controlMenu];
}

-(void) initScoreBoard
{
    _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", _score] fontName:@"Marker Felt" fontSize:32];
    _label.position = ccp([UIScreen mainScreen].bounds.size.height/2, 15);
    [self addChild:_label];
}

-(void) scorePlus: (NSNotification *) notification
{
    _score++;
    _label.string = [NSString stringWithFormat:@"%d", _score];
}

-(void) gameOver: (NSNotification *) notification
{
    CCScene *newScene = [SRGameOverBoardLayer sceneWithFinalScore:_score];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:newScene]];
}

/*-(void) initGameOverLabel
{
    CCMenuItemImage *gameOverImage = [CCMenuItemImage itemWithNormalImage:@"gameOver.png" selectedImage:@"gameOver.png"];
    gameOverImage.scale = 0.5;
    gameOverImage.position = ccp([UIScreen mainScreen].bounds.size.height/2, 200);
    
    CCMenu *gameOverMenu = [CCMenu menuWithItems:gameOverImage, nil];
    gameOverMenu.position = CGPointZero;
    [self addChild:gameOverMenu];
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

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
