//
//  SRGlobal.m
//  StarWar
//
//  Created by Shuangqing on 14-8-11.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRGlobal.h"

static BOOL hasShield;

@implementation SRGlobal

+ (BOOL)hasShield
{
    return hasShield;
}

+ (void)setHasShield:(BOOL)shield
{
    hasShield = shield;
}

@end
