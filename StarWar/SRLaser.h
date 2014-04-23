//
//  SRLaser.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCPhysicsSprite.h"
#import "cocos2d.h"
#import "Box2D.h"

@interface SRLaser : CCPhysicsSprite
-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withRotation:(float)rotation;
@end
