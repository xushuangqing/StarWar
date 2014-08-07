//
//  SRStarBatch.h
//  StarWar
//
//  Created by Shuangqing on 14-8-7.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCSpriteBatchNode.h"
#import "cocos2d.h"
#import "Box2D.h"

@interface SRStarBatch : CCSpriteBatchNode

- (void)createStarBatchForWorld:(b2World *)world;

@end
