//
//  SRGameOverBoard.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRGameOverBoardLayer.h"
#import "AppDelegate.h"
#import "Score.h"
#import "SRConstants.h"

@implementation SRGameOverBoardLayer

+(CCScene *) sceneWithFinalScore: (int)finalScore
{
	CCScene *scene = [CCScene node];
	SRGameOverBoardLayer *layer = [[[SRGameOverBoardLayer alloc] initWithFinalScore:finalScore] autorelease];
	[scene addChild:layer];
	return scene;
}

-(id) initWithFinalScore: (int)finalScore
{
	if( (self=[super init])) {
        [self initMenuWithFinalScore: finalScore];
        [self saveCurrentScore: finalScore];
	}
	return self;
}

-(void) initMenuContent
{
    [self initButtonMenu];
    [self initBackButton];
    [self initPlayAgainButton];
}

-(void) initMenuWithFinalScore: (int)finalScore
{
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"titleYourFinalScore.png" selectedImage:@"titleYourFinalScore.png"];
    title.scale = 0.5;
    title.position = ccp([UIScreen mainScreen].bounds.size.height/2, 260);
    
    CCMenuItem *bestScore = [CCMenuItemAtlasFont itemWithString:[NSString stringWithFormat:@"%d", finalScore] charMapFile:@"number.png" itemWidth:25.4 itemHeight:27 startCharMap:'0'];;
    bestScore.position = ccp([UIScreen mainScreen].bounds.size.height/2, 200);
    
    CCMenu* menu = [CCMenu menuWithItems:title, bestScore, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zMenu tag:kTagMenu];
}

-(void) saveCurrentScore: (int)score
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    Score *finalScore = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:context];
    
    finalScore.timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]*1000];
    finalScore.isPushed = [NSNumber numberWithBool:NO];
    finalScore.score = [NSNumber numberWithInt:score];
    
    [app saveContext];
}

@end
