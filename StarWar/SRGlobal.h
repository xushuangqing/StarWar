//
//  SRGlobal.h
//  StarWar
//
//  Created by Shuangqing on 14-11-25.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SRGameStatus) {
    SRStatusRunning,
    SRStatusPause,
    SRStatusStop,
};

@interface SRGlobal : NSObject

+ (void)setGameStatus:(SRGameStatus)status;
+ (SRGameStatus)gameStatus;

@end
