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
#import "AppDelegate.h"
#import "SRScoreBoardLayer.h"
#import "SRGameOverBoardLayer.h"
#import "SRMainMenuLayer.h"

@implementation SRControlLayer
{
    CCLabelAtlas* _label;
    CCMenuItem *_plusButton;
    CCMenuItem *_minusButton;
}

- (id)init
{
    if (self = [super init]) {
        _score = 0;
        [self registerNotifications];
        [self initButton];
        [self initScoreBoard];
        [self schedule:@selector(watchOverButtonPressed) interval:0.1];
    }
    return self;
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scorePlus:) name:NSNotificationNameScorePlus object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipTouchPlane object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipTooFar object:nil];
}

- (void)initButton
{
    _plusButton = [CCMenuItemImage itemWithNormalImage:@"plus.png" selectedImage:@"plus.png" target:self selector:@selector(plusButtonPressed:)];
    _plusButton.anchorPoint = ccp(0, 0);
    _plusButton.position = ccp(0, 0);
    
    _minusButton = [CCMenuItemImage itemWithNormalImage:@"minus.png" selectedImage:@"minus.png" target:self selector:@selector(minusButtonPressed:)];
    _minusButton.anchorPoint = ccp(1, 0);
    _minusButton.position = ccp([UIScreen mainScreen].bounds.size.height, 0);
    
    CCMenu *controlMenu = [CCMenu menuWithItems:_plusButton, _minusButton, nil];
    controlMenu.position = CGPointZero;
    [self addChild:controlMenu];
}

- (void)initScoreBoard
{
    _label = [CCLabelAtlas labelWithString:@"0" charMapFile:@"number@2x.png" itemWidth:23 itemHeight:31 startCharMap:'0'];
    _label.position = ccp([UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width - 35.);
    _label.anchorPoint = ccp(0.5, 0.5);
    [self addChild:_label];
}

- (void)scorePlus: (NSNotification *) notification
{
    _score++;
    _label.string = [NSString stringWithFormat:@"%d", _score];
}

- (void)gameOver: (NSNotification *) notification
{
    CCScene *newScene = [SRGameOverBoardLayer sceneWithFinalScore:_score];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:newScene]];
}

- (void)buttonPressed: (id)sender isPlusButton: (BOOL)plus
{
    CCMenuItem *menuItem = (CCMenuItem*) sender;
    CGPoint origion = menuItem.position;
    if (plus) {
        menuItem.position = ccp(origion.x-1, origion.y-1);
    }
    else {
        menuItem.position = ccp(origion.x+1, origion.y-1);
    }
    CCMoveTo *moveBack = [CCMoveTo actionWithDuration:0.1 position:origion];
    [menuItem runAction:moveBack];
}

- (void)plusButtonPressed: (id)sender
{
    [self buttonPressed:sender isPlusButton:YES];
    [self.delegate controlLayerDidPressPlusButton:self];
}

- (void)minusButtonPressed: (id)sender
{
    [self buttonPressed:sender isPlusButton:NO];
    [self.delegate controlLayerDidPressMinusButton:self];
}

- (void)disableMenuButton
{
    _plusButton.isEnabled = NO;
    _minusButton.isEnabled = NO;
}

- (void)enableMenuButton
{
    _plusButton.isEnabled = YES;
    _minusButton.isEnabled = YES;
}

- (void)watchOverButtonPressed
{
    if ([_plusButton isSelected]) {
        [self plusButtonPressed:nil];
    }
    if ([_minusButton isSelected]) {
        [self minusButtonPressed:nil];
    }
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.delegate release];
    [super dealloc];
}

@end
