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
        [self initButton];
    }
    return self;
}

-(void) initButton
{
    CCMenuItem *plusButton = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png" target:self selector:@selector(plusButtonPressed)];
    plusButton.position = ccp(60, 60);
    
    CCMenuItem *minusButton = [CCMenuItemImage itemWithNormalImage:@"blocks.png" selectedImage:@"blocks.png" target:self selector:@selector(minusButtonPressed)];
    minusButton.position = ccp(400, 60);
    
    CCMenu *menu = [CCMenu menuWithItems:plusButton,minusButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu];
}

-(void) plusButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNamePlusVelocity object:nil];
}

-(void) minusButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameMinusVelocity object:nil];
}

@end
