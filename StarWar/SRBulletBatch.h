//
//  SRBulletBatch.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-20.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "SRSpaceShip.h"

@interface SRBulletBatch : CCSpriteBatchNode
{
    b2World* _world;
    SRSpaceShip* _spaceShip;
    
}

-(void)createBulletBatchForWorld: (b2World *)world withSpaceShip: (SRSpaceShip *)spaceShip;

@end
