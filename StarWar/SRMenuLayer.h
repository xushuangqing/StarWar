//
//  SRMenuLayer.h
//  StarWar
//
//  Created by XuShuangqing on 14-5-16.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"

@interface SRMenuLayer : CCLayer

- (void)initButtonMenu;
-(NSArray *) dataFetchRequest;
-(void)buttonPressed: (id)sender;
@end
