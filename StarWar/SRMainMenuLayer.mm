//
//  SRMainMenuLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRMainMenuLayer.h"
#import "SRSpaceLayer.h"
#import "SRConstants.h"
#import "SRSpaceScene.h"

@implementation SRMainMenuLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SRMainMenuLayer *layer = [SRMainMenuLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( (self=[super init])) {
        [self initMenu];
	}
	return self;
}

- (void)initMenu
{
    CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"buttonPlay@2x.png" selectedImage:@"buttonPlay@2x.png" target:self selector:@selector(startButtonPressed:)];
    startButton.position = ccp([UIScreen mainScreen].bounds.size.height/2, 210);
    
    CCMenu* menu = [CCMenu menuWithItems:startButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zMenu tag:kTagMenu];
}

- (void)startButtonPressed:(id)sender
{
    [self buttonPressed:sender];
    NSLog(@"startButtonPressed");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceScene node]]];
}


@end
