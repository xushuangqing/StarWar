//
//  SRBullet.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-19.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"
#import "CCPhysicsSprite.h"
#import "Box2D.h"

@interface SRBullet : CCPhysicsSprite

-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withVelocity:(b2Vec2)velocity;

@end
