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

-(void) initMenuContent
{
    [self initMenu];
}

-(void) initMenu
{
    CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"buttonPlay@2x.png" selectedImage:@"buttonPlay@2x.png" target:self selector:@selector(startButtonPressed:)];
    startButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 210);
    
    CCMenuItem *scoreBoardButton = [CCMenuItemImage itemWithNormalImage:@"buttonHighScores@2x.png" selectedImage:@"buttonHighScores@2x.png" target:self selector:@selector(scoreBoardButtonPressed:)];
    scoreBoardButton.scale = 0.8;
    scoreBoardButton.position = ccp([UIScreen mainScreen].bounds.size.height/5, 90);
    
    CCMenuItem *helpButton = [CCMenuItemImage itemWithNormalImage:@"buttonHelp@2x.png" selectedImage:@"buttonHelp@2x.png" target:self selector:@selector(scoreBoardButtonPressed:)];
    helpButton.scale = 0.8;
    helpButton.position = ccp([UIScreen mainScreen].bounds.size.height/5*4, 90);
    
    CCMenu* menu = [CCMenu menuWithItems:startButton, scoreBoardButton, helpButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zMenu tag:kTagMenu];
}

-(void) startButtonPressed: (id)sender
{
    [self buttonPressed:sender];
    NSLog(@"startButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceLayer scene] ]];
}

-(void) scoreBoardButtonPressed: (id)sender
{
    [self buttonPressed:sender];
    NSLog(@"scoreBoardButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRScoreBoardLayer scene] ]];
}


@end
