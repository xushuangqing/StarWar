//
//  SRSpaceLayer.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "SRSpaceShip.h"
#import "SREarth.h"

@interface SRSpaceLayer : CCLayer{
}

@property (retain) SRSpaceShip *spaceShip;
@property (retain) SREarth *earth;


+(CCScene *)scene;

@end
