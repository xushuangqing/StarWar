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
#import "Score.h"

@implementation SRGameOverBoardLayer
{
    NSOperationQueue *_operationQueue;
    NSURLConnection *_connection;
}

+ (CCScene *)sceneWithFinalScore:(NSInteger)finalScore
{
	CCScene *scene = [CCScene node];
	SRGameOverBoardLayer *layer = [[[SRGameOverBoardLayer alloc] initWithFinalScore:finalScore] autorelease];
	[scene addChild:layer];
	return scene;
}

- (id)initWithFinalScore: (int)finalScore
{
	if( (self=[super init])) {
        [self initMenuContent];
        [self initMenuWithFinalScore: finalScore];
        [self saveCurrentScore: finalScore];
        [self pushScoreToRemoteServer];
	}
	return self;
}

- (void)initMenuContent
{
    [self initButtonMenu];
    [self initBackButton];
    [self initPlayAgainButton];
}

- (void)initBackButton
{
    CCMenuItem *backButton = [CCMenuItemImage itemWithNormalImage:@"buttonMainMenu@2x.png" selectedImage:@"buttonMainMenu@2x.png" target:self selector:@selector(backToMainMenu:)];
    backButton.anchorPoint = ccp(1, 0);
    backButton.position = ccp([UIScreen mainScreen].bounds.size.height, 0);
    
    CCMenu* menu = (CCMenu *)[self getChildByTag:kTagButtonMenu];
    [menu addChild:backButton];
}

- (void)initPlayAgainButton
{
    CCMenuItem *playAgainButton = [CCMenuItemImage itemWithNormalImage:@"buttonPlayAgain@2x.png" selectedImage:@"buttonPlayAgain@2x.png" target:self selector:@selector(playAgain:)];
    playAgainButton .anchorPoint = ccp(0, 0);
    playAgainButton .position = ccp(0, 0);
    
    CCMenu* menu = (CCMenu *)[self getChildByTag:kTagButtonMenu];
    [menu addChild:playAgainButton];
}

-(void) initMenuWithFinalScore: (int)finalScore
{
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"titleYourFinalScore.png" selectedImage:@"titleYourFinalScore.png"];
    title.scale = 0.5;
    title.position = ccp([UIScreen mainScreen].bounds.size.height/2, 260);
    
    CCMenuItem *bestScore = [CCMenuItemAtlasFont itemWithString:[NSString stringWithFormat:@"%d", finalScore] charMapFile:@"number@2x.png" itemWidth:23 itemHeight:31 startCharMap:'0'];;
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

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

-(void) deleteScoreObjectsExceptBestScore
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    NSArray *array = [self dataFetchRequest];
    
    BOOL isFirst = true;
    for (Score *score in array) {
        if (isFirst) {
            score.isPushed = @YES;
            isFirst = false;
            continue;
        }
        [context deleteObject:score];
    }
    [app saveContext];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (jsonDic && [jsonDic isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)jsonDic;
    }
    [self deleteScoreObjectsExceptBestScore];
}

-(NSData *) convertToJsonDataFromArray: (NSArray *)array
{
    NSMutableArray *jsonArray = [[NSMutableArray alloc] init];
    
    for (Score* score in array) {
        if (![score.isPushed boolValue]) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:score.timestamp, @"timestamp", score.score, @"score", nil];
            [jsonArray addObject: dic];
        }
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:&error];
    
    [jsonArray release];
    return jsonData;
}

-(void) pushScoreToRemoteServer
{
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverURL, scoreURL]]];
    [request setHTTPMethod:@"POST"];
    

    NSArray* scoreArray = [self dataFetchRequest];
    NSData *jsonData = [self convertToJsonDataFromArray:scoreArray];
    [request setHTTPBody:jsonData];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    _operationQueue = [[NSOperationQueue alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection setDelegateQueue:_operationQueue];
    [_connection start];
}

-(void) dealloc
{
    [_connection release];
    [_operationQueue release];
    [super dealloc];
}

@end
