//
//  SRControlLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRControlLayer.h"
#import "SRConstants.h"

@implementation SRControlLayer

-(id) init
{
    if (self = [super init]) {
        [self initPlusButton];
    }
    return self;
}

-(void) initPlusButton
{
    CCMenuItem *plusButton = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png" target:self selector:@selector(plusButtonPressed)];
    plusButton.position = ccp(60, 60);
    
    CCMenu *menu = [CCMenu menuWithItems:plusButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu];
}

-(void) plusButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNamePlusVelocity object:nil];
}

@end
