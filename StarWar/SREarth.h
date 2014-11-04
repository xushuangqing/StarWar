//
//  SREarth.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCPhysicsSprite.h"
#import "Box2D.h"

@interface SREarth : CCPhysicsSprite

@property b2Vec2 geocentric;

- (void)createBodyForWorld:(b2World *)world withRadius:(float)radius withAngularVelocity:(float)angularVelocity;

@end
