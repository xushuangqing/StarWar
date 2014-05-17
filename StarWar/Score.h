//
//  Score.h
//  StarWar
//
//  Created by XuShuangqing on 14-5-10.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Score : NSManagedObject

@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSNumber * isPushed;

-(NSString*) timestamp;
-(NSNumber*) score;
-(NSNumber*) isPushed;
-(void) setTimestamp:(NSString *)timestamp;
-(void) setScore:(NSNumber *)score;
-(void) setIsPushed:(NSNumber *)isPushed;


@end
