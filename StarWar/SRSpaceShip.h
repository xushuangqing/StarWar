//
//  SRStar.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright 2014年 XuShuangqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCPhysicsSprite.h"
#import "Box2D.h"


@interface SRSpaceShip : CCPhysicsSprite {
}
-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withGeocentric:(b2Vec2)geocentric withVelocity:(b2Vec2)velocity;
@end
