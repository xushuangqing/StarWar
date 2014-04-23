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

@interface SRPlaneBatch ()
{
    b2World* _world;
    b2Vec2 _geocentric;
}

@end

@implementation SRPlaneBatch


-(void)createBulletBatchForWorld: (b2World *)world withGeocentric: (b2Vec2)geocentric
{
    _world = world;
    [self schedule:@selector(addPlane) interval:1];
    [self scheduleUpdate];
}

-(void)addPlane
{
    SRPlane* plane = [SRPlane node];
    
    CGPoint position = [self convertToNodeSpace:ccp(100, 300)];
    
    
    [plane createBodyForWorld:_world withGeocentric:_geocentric];
    plane.position = position;
    [self addChild:plane];
}

@end
