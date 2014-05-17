//
//  SRGameOverBoard.h
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"
#import "SRMenuLayer.h"
#import <CoreData/CoreData.h>

@interface SRGameOverBoardLayer : SRMenuLayer

+(CCScene *) sceneWithFinalScore: (int)finalScore;

@end
