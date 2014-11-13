//
//  SRPlane.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "Box2D.h"
#import "SRAircraft.h"

@interface SRPlane : SRAircraft

@property (nonatomic, assign) BOOL isAlive;

- (void)createBodyForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric withPosition:(b2Vec2)position withLinearVelocity:(b2Vec2)linearVelocity;
- (void)hitByLaser;

@end
