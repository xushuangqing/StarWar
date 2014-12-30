//
//  SRPlaneBatch.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRPlaneBatch.h"
#import "SRConstants.h"
#import "SRPlane.h"
#import "cocos2d.h"

@implementation SRPlaneBatch
{
    b2World *_world;
    b2Vec2 _geocentric;
}

- (void)createPlaneBatchForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric
{
    _world = world;
    [self schedule:@selector(addPlane) interval:1];
    [self scheduleUpdate];
    _geocentric = geocentric;
}

- (b2Vec2)linearVelocityForCircularMotionWithPosition:(b2Vec2)position
{
    float sqrRadius = powf((position.x-_geocentric.x), 2) + powf((position.y-_geocentric.y), 2);
    float radius = sqrtf(sqrRadius);
    float velocity = sqrtf(GM/radius);
    
    float velocityX = -velocity/radius*(position.y-_geocentric.y);
    float velocityY = velocity/radius*(position.x-_geocentric.x);
    
    b2Vec2 velocityVec(velocityX, velocityY);
    return velocityVec;
}

- (void)addPlane
{
    float y = CCRANDOM_0_1()*[UIScreen mainScreen].bounds.size.height;
    CGPoint ccpPosition = [self convertToNodeSpace:ccp([UIScreen mainScreen].bounds.size.width+PTM_RATIO, y)];
    b2Vec2 position(ccpPosition.x/PTM_RATIO, ccpPosition.y/PTM_RATIO);
    if (!position.IsValid()) {
        return;
    }

    SRPlane* plane = [SRPlane spriteWithTexture:[self texture]];
    b2Vec2 velocity = [self linearVelocityForCircularMotionWithPosition:position];
    [plane createBodyForWorld:_world withGeocentric:_geocentric withPosition:position withLinearVelocity:velocity];
    [self addChild:plane];
}

- (void)update:(ccTime)delta
{
    NSMutableArray *toBeDeleted = [[NSMutableArray alloc] init];
    for (SRPlane* plane in self.children) {
        CGPoint worldPosition = [self convertToWorldSpace:plane.position];
        if (worldPosition.x > [UIScreen mainScreen].bounds.size.width+PTM_RATIO+PTM_RATIO || worldPosition.y > [UIScreen mainScreen].bounds.size.height+PTM_RATIO || worldPosition.x < -PTM_RATIO || worldPosition.y < -PTM_RATIO) {
            [toBeDeleted addObject:plane];
        }
    }
    
    for (SRPlane* plane in toBeDeleted) {
        [self removeChild:plane cleanup:YES];
        _world->DestroyBody(plane.b2Body);
        plane.b2Body = NULL;
        plane = NULL;
    }
    
    [toBeDeleted release];
}

- (void)pauseSchedulerAndActions
{
    [super pauseSchedulerAndActions];
    for (CCNode *child in self.children) {
        [child pauseSchedulerAndActions];
    }
}

- (void)resumeSchedulerAndActions
{
    [super resumeSchedulerAndActions];
    for (CCNode *child in self.children) {
        [child resumeSchedulerAndActions];
    }
}

@end
