//
//  SRGameOverLayer.h
//  StarWar
//
//  Created by Shuangqing on 14-10-30.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCLayer.h"

@protocol SRGameOverLayerProtocal;

@interface SRGameOverLayer : CCLayer

@property (nonatomic, unsafe_unretained) id<SRGameOverLayerProtocal> delegate;

- (void)initGameOverMenu;
- (void)setFinalScore:(NSInteger)score;

@end

@protocol SRGameOverLayerProtocal <NSObject>

- (void)gameOverLayerDidPressRestartButton:(SRGameOverLayer *)layer;
- (void)gameOverLayerDidPressMainMenuButton:(SRGameOverLayer *)layer;

@end
