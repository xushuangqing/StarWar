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
    [self scheduleUpdate];
}

-(void)addBullet
{
    SRBullet* bullet = [SRBullet spriteWithTexture:self.texture];
    [bullet createBodyForWorld:_world withPosition:_spaceShip.b2Body->GetPosition() withVelocity:_spaceShip.b2Body->GetLinearVelocity()];
    [self addChild:bullet];
}

-(void) update:(ccTime)delta
{
    for (SRBullet* bullet in self.children) {
        CGPoint position = [self convertToWorldSpace:bullet.position];
        
        if (position.x > [UIScreen mainScreen].bounds.size.height || position.y > [UIScreen mainScreen].bounds.size.width || position.x < 0 || position.y < 0) {
            _world->DestroyBody(bullet.b2Body);
            bullet.b2Body = NULL;
            [self removeChild:bullet cleanup:YES];
            bullet = NULL;
        }
    }
}

@end
