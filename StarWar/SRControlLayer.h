//
//  SRControlLayer.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCLayer.h"

@protocol SRControlLayerDelegate;

@interface SRControlLayer : CCLayer

@property (nonatomic, unsafe_unretained) id<SRControlLayerDelegate> delegate;

- (void)fadeOut;
- (void)setMenuEnabled:(BOOL)enabled;

@end

@protocol SRControlLayerDelegate <NSObject>

- (void)controlLayerDidPressPlusButton:(SRControlLayer *)controlLayer;
- (void)controlLayerDidPressMinusButton:(SRControlLayer *)controlLayer;
- (void)controlLayer:(SRControlLayer *)controlLayer gameOverWithFinalScore:(NSInteger)score;

@end
