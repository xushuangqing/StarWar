//
//  SRGameControlLayer.h
//  StarWar
//
//  Created by Shuangqing on 14-10-26.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCLayer.h"
#import "SRGlobal.h"


@protocol SRGameControlLayerDelegate;

@interface SRGameControlLayer : CCLayer

@property (nonatomic, unsafe_unretained) id<SRGameControlLayerDelegate> delegate;

- (void)changeGameStatusTo:(SRGameStatus)status;

@end

@protocol SRGameControlLayerDelegate <NSObject>

- (void)gameControlLayerDidPressPauseButton:(SRGameControlLayer *)controlLayer;
- (void)gameControlLayerDidPressResumeButton:(SRGameControlLayer *)controlLayer;
- (void)gameControlLayerDidPressRestartButton:(SRGameControlLayer *)controlLayer;

@end