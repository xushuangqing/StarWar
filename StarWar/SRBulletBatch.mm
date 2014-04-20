//
//  SRBulletBatch.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-20.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRBulletBatch.h"
#import "SRBullet.h"
#import "SRSpaceShip.h"

@implementation SRBulletBatch

-(void)createBulletBatchForWorld: (b2World *)world withSpaceShip: (SRSpaceShip *)spaceShip
{
    _world = world;
    _spaceShip = spaceShip;
    [self schedule:@selector(addBullet) interval:1];
}

-(void)addBullet
{
    SRBullet* bullet = [SRBullet node];
    [bullet createBodyForWorld:_world withPosition:_spaceShip.b2Body->GetPosition() withVelocity:_spaceShip.b2Body->GetLinearVelocity()];
    [self addChild:bullet];
}

@end
