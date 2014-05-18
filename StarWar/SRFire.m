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
        [self registerNotification];
    }
    return self;
}

-(void) registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusVelocity:) name:NSNotificationNamePlusVelocity object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusVelocity:) name:NSNotificationNameMinusVelocity object:nil];
}

-(void) plusVelocity: (NSNotification *) notification
{
    CCScaleTo *enlarge = [CCScaleTo actionWithDuration:0.1 scaleX:1.1 scaleY:1];
    CCScaleTo *narrow = [CCScaleTo actionWithDuration:1 scaleX:1 scaleY:1];
    [self runAction:[CCSequence actions:enlarge, narrow, nil]];
}

-(void) minusVelocity: (NSNotification *) notification
{
    CCScaleTo *narrow = [CCScaleTo actionWithDuration:0.1 scaleX:0.9 scaleY:1];
    CCScaleTo *enlarge = [CCScaleTo actionWithDuration:1 scaleX:1 scaleY:1];
    [self runAction:[CCSequence actions:narrow, enlarge, nil]];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
