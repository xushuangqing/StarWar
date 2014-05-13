//
//  SRGameOverBoard.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRGameOverBoardLayer.h"

@implementation SRGameOverBoardLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SRGameOverBoardLayer *layer = [SRGameOverBoardLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init])) {

	}
	return self;
}

@end
