//
//  SRPlaneBatch.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCSpriteBatchNode.h"
#import "Box2D.h"

@interface SRPlaneBatch : CCSpriteBatchNode

- (void)createPlaneBatchForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric;

@end
