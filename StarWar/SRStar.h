//
//  SRStar.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-18.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "CCPhysicsSprite.h"
#import "Box2D.h"
#import "cocos2d.h"

@interface SRStar : CCPhysicsSprite

-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position;

@end
