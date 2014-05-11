//
//  UserData.h
//  StarWar
//
//  Created by XuShuangqing on 14-5-10.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;

@end
