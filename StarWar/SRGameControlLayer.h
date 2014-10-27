//
//  SRGameControlLayer.h
//  StarWar
//
//  Created by Shuangqing on 14-10-26.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCLayer.h"

@protocol SRGameControlLayerDelegate;

@interface SRGameControlLayer : CCLayer

@property (retain) id<SRGameControlLayerDelegate> delegate;

@end

@protocol SRGameControlLayerDelegate <NSObject>

- (void)gameControlLayerDidPressPauseButton:(SRGameControlLayer *)controlLayer;
- (void)gameControlLayerDidPressResumeButton:(SRGameControlLayer *)controlLayer;

@end