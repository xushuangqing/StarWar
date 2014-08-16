//
//  SRStarBatch.m
//  StarWar
//
//  Created by Shuangqing on 14-8-7.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRStarBatch.h"
#import "SRStar.h"
#import "SRShieldStar.h"
#import "SRConstants.h"

@implementation SRStarBatch
{
    b2World *_world;
}

- (void)createStarBatchForWorld:(b2World *)world
{
    _world = world;
    [self schedule:@selector(addShieldStar) interval:1];
    [self scheduleUpdate];
}

- (void)addShieldStar
{
    SRShieldStar *shieldStar = [SRShieldStar spriteWithTexture:[self texture]];
    float y = CCRANDOM_0_1()*[UIScreen mainScreen].bounds.size.width;
    CGPoint ccpPosition = [self convertToNodeSpace:ccp([UIScreen mainScreen].bounds.size.height+PTM_RATIO, y)];
    b2Vec2 position(ccpPosition.x/PTM_RATIO, ccpPosition.y/PTM_RATIO);
    [shieldStar createBodyForWorld:_world withPosition:position];
    [self addChild:shieldStar];
}

-(void)update:(ccTime)delta
{
    NSMutableArray *toBeDeleted = [[NSMutableArray alloc] init];
    for (SRStar* star in self.children) {
        CGPoint worldPosition = [self convertToWorldSpace:star.position];

        if (worldPosition.x > [UIScreen mainScreen].bounds.size.height+PTM_RATIO+PTM_RATIO || worldPosition.y > [UIScreen mainScreen].bounds.size.width+PTM_RATIO || worldPosition.x < -PTM_RATIO || worldPosition.y < -PTM_RATIO) {
            [toBeDeleted addObject:star];
        }
    }

    for (SRStar* star in toBeDeleted) {
        [self removeChild:star cleanup:YES];
        _world->DestroyBody(star.b2Body);
        star.b2Body = NULL;
        star = NULL;
    }

    [toBeDeleted release];
}

@end
