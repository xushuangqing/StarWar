//
//  SRMainMenuLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRMainMenuLayer.h"
#import "SRSpaceLayer.h"
#import "SRScoreBoardLayer.h"
#import "SRConstants.h"

@implementation SRMainMenuLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SRMainMenuLayer *layer = [SRMainMenuLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) initMenu
{
    CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"buttonPlay.png" selectedImage:@"buttonPlay.png" target:self selector:@selector(startButtonPressed)];
    startButton.scale = 0.5;
    startButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 210);
    
    CCMenuItem *scoreBoardButton = [CCMenuItemImage itemWithNormalImage:@"buttonHighScores.png" selectedImage:@"buttonHighScores.png" target:self selector:@selector(scoreBoardButtonPressed)];
    scoreBoardButton.scale = 0.5;
    scoreBoardButton.position = ccp([UIScreen mainScreen].bounds.size.height/5, 90);
    
    CCMenuItem *helpButton = [CCMenuItemImage itemWithNormalImage:@"buttonHelp.png" selectedImage:@"buttonHelp.png" target:self selector:@selector(scoreBoardButtonPressed)];
    helpButton.scale = 0.5;
    helpButton.position = ccp([UIScreen mainScreen].bounds.size.height/5*4, 90);
    
    _mainMenu = [CCMenu menuWithItems:startButton, scoreBoardButton, helpButton, nil];
    _mainMenu.position = CGPointZero;
    [self addChild:_mainMenu z:zMenu tag:kTagMenu];
}

-(void) startButtonPressed
{
    NSLog(@"startButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceLayer scene] ]];
}

-(void) scoreBoardButtonPressed
{
    NSLog(@"scoreBoardButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRScoreBoardLayer scene] ]];
}


@end
