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

typedef NS_ENUM(NSUInteger, Status) {
    StatusRunning,
    StatusPause,
    StatusOther,
};

@implementation SRControlLayer
{
    CCLabelAtlas* _label;
    Status _currentStatus;
}

-(id) init
{
    if (self = [super init]) {
        _score = 0;
        _currentStatus = StatusRunning;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:NSNotificationNameSpaceShipTooFar object:nil];
}

-(void) initButton
{
    CCMenuItem *plusButton = [CCMenuItemImage itemWithNormalImage:@"plus.png" selectedImage:@"plus.png" target:self selector:@selector(plusButtonPressed:)];
    plusButton.anchorPoint = ccp(0, 0);
    plusButton.scale = 0.5;
    plusButton.position = ccp(0, 0);
    
    CCMenuItem *minusButton = [CCMenuItemImage itemWithNormalImage:@"minus.png" selectedImage:@"minus.png" target:self selector:@selector(minusButtonPressed:)];
    minusButton.anchorPoint = ccp(1, 0);
    minusButton.scale = 0.5;
    minusButton.position = ccp([UIScreen mainScreen].bounds.size.height, 0);
    
    CCMenuItem *pauseButton = [CCMenuItemImage itemWithNormalImage:@"minus.png" selectedImage:@"minus.png" target:self selector:@selector(pauseButtonPressed:)];
    pauseButton.anchorPoint = ccp(1, 0);
    pauseButton.scale = 0.5;
    pauseButton.position = ccp([UIScreen mainScreen].bounds.size.height, 200);
    
    CCMenu *controlMenu = [CCMenu menuWithItems:plusButton,minusButton,pauseButton, nil];
    controlMenu.position = CGPointZero;
    [self addChild:controlMenu];
}

-(void) initScoreBoard
{
    _label = [CCLabelAtlas labelWithString:@"0" charMapFile:@"number.png" itemWidth:25.4 itemHeight:28 startCharMap:'0'];
    _label.position = ccp([UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width - 20);
    _label.anchorPoint = ccp(0.5, 1);
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

-(void) buttonPressed: (id)sender isPlusButton: (BOOL)plus
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

-(void) plusButtonPressed: (id)sender
{
    [self buttonPressed:sender isPlusButton:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNamePlusVelocity object:nil];
    //[self energe];
}

-(void) minusButtonPressed: (id)sender
{
    [self buttonPressed:sender isPlusButton:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameMinusVelocity object:nil];
    //[self energe];
}

-(void) pauseButtonPressed: (id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNamePause object:nil];
    _currentStatus = StatusPause;
}

//not used
-(void) energe
{
    SRSpaceLayer *spaceLayer = (SRSpaceLayer*)[[[CCDirector sharedDirector] runningScene] getChildByTag:kTagSpaceLayer];
    b2Vec2 spaceShipPosition = spaceLayer.spaceShip.b2Body->GetPosition();
    b2Vec2 earthPosition = spaceLayer.earth.b2Body->GetPosition();
    b2Vec2 spaceShipVelocity = spaceLayer.spaceShip.b2Body->GetLinearVelocity();
    float distance = sqrtf(powf(spaceShipPosition.x-earthPosition.x, 2)+powf(spaceShipPosition.y-earthPosition.y, 2));
    float v2 = powf(spaceShipVelocity.x, 2)+powf(spaceShipVelocity.y, 2);
    
    float energy = 0.5*v2 - GM/distance;
    NSLog(@"energy:%f", energy);
    
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
