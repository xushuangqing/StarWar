//
//  SRMenuLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRMenuLayer.h"
#import "SRSpaceLayer.h"

@implementation SRMenuLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SRMenuLayer *layer = [SRMenuLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		[self initMenu];
	}
	
	return self;
}

-(void) initMenu
{
    CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"replay.png" selectedImage:@"replay.png" target:self selector:@selector(startButtonPressed)];
    startButton.scale = 0.5;
    startButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 200);
    
    CCMenuItem *scoreBoardButton = [CCMenuItemImage itemWithNormalImage:@"replay.png" selectedImage:@"replay.png" target:self selector:@selector(scoreBoardButtonPressed)];
    scoreBoardButton.scale = 0.5;
    scoreBoardButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 100);
    
    _mainMenu = [CCMenu menuWithItems:startButton, scoreBoardButton, nil];
    _mainMenu.position = CGPointZero;
    [self addChild:_mainMenu];
}

-(void) startButtonPressed
{
    NSLog(@"startButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceLayer scene] ]];
}

-(void) scoreBoardButtonPressed
{
    NSLog(@"scoreBoardButtonPressed");
}


@end
