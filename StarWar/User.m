//
//  User.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-10.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic name;
@dynamic score;

-(NSString*) name
{
    return [self valueForKey:@"name"];
}

-(NSNumber*) score
{
    return [self valueForKey:@"score"];
}

-(void) setName:(NSString *)name
{
    [self setValue:name forKey:@"name"];
}

-(void) setScore:(NSNumber *)score
{
    [self setValue:score forKey:@"score"];
}


@end
