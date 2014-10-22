//
//  SRFire.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-18.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRFire.h"
#import "SRConstants.h"

@implementation SRFire

-(id) initWithFile:(NSString *)filename
{
    if (self = [super initWithFile:filename]) {
        self.anchorPoint = ccp(1, 0.5);
    }
    return self;
}

-(void) dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
