//
//  SRShieldStar.m
//  StarWar
//
//  Created by Shuangqing on 14-8-8.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRShieldStar.h"
#import "SRGlobal.h"

@implementation SRShieldStar

- (void)touched
{
    [super touched];
    [SRGlobal setHasShield:YES];
}

@end
