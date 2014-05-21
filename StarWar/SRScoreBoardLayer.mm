//
//  SRScoreBoardLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRScoreBoardLayer.h"
#import "SRConstants.h"
#import "Score.h"

@interface SRScoreBoardLayer ()
{
    NSOperationQueue *_operationQueue;
    NSURLConnection *_connection;
}
@end

@implementation SRScoreBoardLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SRScoreBoardLayer *layer = [SRScoreBoardLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        [self fetchBestScore];
        [self getGlobleTop100FromRemoteServer];
	}
	return self;
}

-(void) initMenuContent
{
    [self initMenu];
    [self initButtonMenu];
    [self initBackButton];
}

-(void) initMenu
{
    CCMenuItemImage *titleHighScores = [CCMenuItemImage itemWithNormalImage:@"titleHighScores.png" selectedImage:@"titleHighScores.png"];
    titleHighScores.scale = 0.5;
    titleHighScores.position = ccp([UIScreen mainScreen].bounds.size.height/2, 260);
    
    CCMenuItemImage *titleYourBestScore = [CCMenuItemImage itemWithNormalImage:@"titleYourBestScore.png" selectedImage:@"titleYourBestScore.png"];
    titleYourBestScore.scale = 0.5;
    titleYourBestScore.position = ccp([UIScreen mainScreen].bounds.size.height/4, 220);
    
    CCMenuItemImage *titleGlobleTop100 = [CCMenuItemImage itemWithNormalImage:@"titleGlobleTop100.png" selectedImage:@"titleGlobleTop100.png"];
    titleGlobleTop100.scale = 0.5;
    titleGlobleTop100.position = ccp([UIScreen mainScreen].bounds.size.height/4*3, 220);
    
    CCMenu *menu = [CCMenu menuWithItems:titleHighScores, titleYourBestScore, titleGlobleTop100, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zMenu tag:kTagMenu];
}

-(void) fetchBestScore
{
    NSArray *scoreArray = [self dataFetchRequest];
    for (Score *score in scoreArray) {
        CCLabelAtlas *label = [CCLabelAtlas labelWithString:[score.score stringValue] charMapFile:@"number.png" itemWidth:25.4 itemHeight:28 startCharMap:'0'];
        label.anchorPoint = ccp(0.5, 0.5);
        [self addChild:label];
        label.position = ccp([UIScreen mainScreen].bounds.size.height/4, 180);
        break;
    }
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"connect");
    NSError *error;
    id jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *array;
    if (jsonArray && [jsonArray isKindOfClass:[NSArray class]]) {
        array = (NSArray*)jsonArray;
    }
    [self displayGlobleTop100:array];
}

-(void) displayGlobleTop100: (NSArray *)array
{
    if (!array) {
        return;
    }
    for (id dic in array) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = (NSDictionary *)dic;
            NSLog(@"%@", [dictionary objectForKey:@"score"]);
        }
    }
}

-(void) getGlobleTop100FromRemoteServer
{
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverURL, globleScoreURL]]];
    [request setHTTPMethod:@"GET"];
    
    _operationQueue = [[NSOperationQueue alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection setDelegateQueue:_operationQueue];
    [_connection start];
}

-(void) dealloc
{
    [_operationQueue release];
    [_connection release];
    [super dealloc];
}
@end
