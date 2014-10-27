//
//  SRSpaceLayer.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//


#import "CCLayer.h"

@interface SRSpaceLayer : CCLayer

- (void)stopSchedule;
- (void)spaceshipAccelerate;
- (void)spaceshipDecelerate;
- (void)pause;
- (void)resume;

@end
