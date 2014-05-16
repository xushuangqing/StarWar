//
//  SRMenuLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-16.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRMenuLayer.h"
#import "SRConstants.h"

@implementation SRMenuLayer

-(id) init
{
    if( (self=[super init])) {
        [self initMenu];
        [self initBackground];
	}
	return self;
}

-(void) initMenu
{
    
}

-(void) initBackground
{
    [self initBackgroundColor];
    [self initBackgroundEarth];
}

-(void) initBackgroundColor
{
    CCLayerColor *darkBlue = [CCLayerColor layerWithColor:menuBackgroundColor];
    [self addChild:darkBlue z:zBackgroundColor tag:kTagBackgroundColor];
}

-(void) initBackgroundEarth
{
    CCSprite *backgroundEarth = [CCSprite spriteWithFile:@"backgroundEarth.png"];
    backgroundEarth.scale = 0.5;
    backgroundEarth.anchorPoint = ccp(0, 0);
    backgroundEarth.position = ccp(0, 0);
    [self addChild:backgroundEarth z:zBackgroundEarth tag:kTagBackgroundEarth];
}

@end
