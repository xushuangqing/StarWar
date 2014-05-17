//
//  User.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-10.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "Score.h"


@implementation Score

@dynamic timestamp;
@dynamic score;
@dynamic isPushed;

-(NSString*) timestamp
{
    return [self valueForKey:@"timestamp"];
}

-(NSNumber*) score
{
    return [self valueForKey:@"score"];
}

-(NSNumber*) isPushed
{
    return [self valueForKey:@"isPushed"];
}

-(void) setTimestamp:(NSString *)timestamp
{
    [self setValue:timestamp forKey:@"timestamp"];
}

-(void) setScore:(NSNumber *)score
{
    [self setValue:score forKey:@"score"];
}

-(void) setIsPushed:(NSNumber *)isPushed
{
    [self setValue:isPushed forKey:@"isPushed"];
}


@end
