//
//  SRGlobal.m
//  StarWar
//
//  Created by Shuangqing on 14-11-25.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRGlobal.h"

static SRGameStatus gameStatus;

@implementation SRGlobal

+ (void)setGameStatus:(SRGameStatus)status
{
    gameStatus = status;
}

+ (SRGameStatus)gameStatus
{
    return gameStatus;
}

@end
