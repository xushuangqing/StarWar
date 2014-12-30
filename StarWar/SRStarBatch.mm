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
#import "SRGlobal.h"

@implementation SRStarBatch
{
    b2World *_world;
}

- (void)createStarBatchForWorld:(b2World *)world
{
    _world = world;
    [self schedule:@selector(addShieldStar) interval:10];
    [self scheduleUpdate];
}

- (void)addShieldStar
{
    if ([SRGlobal spaceshipShied] == SRShied) {
        return;
    }
    SRStar *star = [SRStar spriteWithTexture:[self texture]];
    float y = CCRANDOM_0_1()*[UIScreen mainScreen].bounds.size.height;
    CGPoint ccpPosition = [self convertToNodeSpace:ccp([UIScreen mainScreen].bounds.size.width+PTM_RATIO, y)];
    b2Vec2 position(ccpPosition.x/PTM_RATIO, ccpPosition.y/PTM_RATIO);
    [star createBodyForWorld:_world withPosition:position];
    [self addChild:star];
}

-(void)update:(ccTime)delta
{
    NSMutableArray *toBeDeleted = [[NSMutableArray alloc] init];
    for (SRStar* star in self.children) {
        CGPoint worldPosition = [self convertToWorldSpace:star.position];

        if (worldPosition.x > [UIScreen mainScreen].bounds.size.width+PTM_RATIO+PTM_RATIO || worldPosition.y > [UIScreen mainScreen].bounds.size.height+PTM_RATIO || worldPosition.x < -PTM_RATIO || worldPosition.y < -PTM_RATIO) {
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
