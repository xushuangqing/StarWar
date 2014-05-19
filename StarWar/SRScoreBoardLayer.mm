//
//  SRScoreBoardLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRScoreBoardLayer.h"
#import "AppDelegate.h"
#import "Score.h"
#import "SRConstants.h"

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
        [self dataFetchRequest];
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

-(void) dataFetchRequest
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Score" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Score *info in fetchedObjects){
        CCLabelAtlas *label = [CCLabelAtlas labelWithString:[info.score stringValue] charMapFile:@"number.png" itemWidth:25.4 itemHeight:28 startCharMap:'0'];
        label.anchorPoint = ccp(0.5, 0.5);
        [self addChild:label];
        label.position = ccp([UIScreen mainScreen].bounds.size.height/4, 180);
        break;
    }
    
    [sortDescriptors release];
    [sortDescriptor release];
}

@end
