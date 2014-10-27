//
//  SRControlLayer.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@protocol SRControlLayerDelegate;

@interface SRControlLayer : CCLayer

@property int score;
@property (retain) id<SRControlLayerDelegate> delegate;

@end

@protocol SRControlLayerDelegate <NSObject>

- (void)controlLayerDidPressPlusButton:(SRControlLayer *)controlLayer;
- (void)controlLayerDidPressMinusButton:(SRControlLayer *)controlLayer;

@end
