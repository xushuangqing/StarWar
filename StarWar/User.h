//
//  User.h
//  StarWar
//
//  Created by XuShuangqing on 14-5-10.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;

-(NSString*) name;
-(NSNumber*) score;
-(void) setName:(NSString *)name;
-(void) setScore:(NSNumber *)score;


@end
