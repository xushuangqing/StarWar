//
//  SRStarBatch.m
//  StarWar
//
//  Created by Shuangqing on 14-8-7.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRStarBatch.h"
#import "SRStar.h"
#import "SRConstants.h"

@implementation SRStarBatch
{
    b2World *_world;
}

- (void)createStarBatchForWorld:(b2World *)world
{
    _world = world;
    [self schedule:@selector(addStar) interval:1];
}

- (void)addStar
{
    SRStar *star = [SRStar spriteWithTexture:[self texture]];
    float y = CCRANDOM_0_1()*[UIScreen mainScreen].bounds.size.width;
    CGPoint ccpPosition = [self convertToNodeSpace:ccp([UIScreen mainScreen].bounds.size.height+PTM_RATIO, y)];
    b2Vec2 position(ccpPosition.x/PTM_RATIO, ccpPosition.y/PTM_RATIO);
    [star createBodyForWorld:_world withPosition:position];
    [self addChild:star];
}

@end
