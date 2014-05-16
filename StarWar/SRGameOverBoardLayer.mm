//
//  SRGameOverBoard.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRGameOverBoardLayer.h"
#import "AppDelegate.h"
#import "User.h"
#import "SRConstants.h"

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
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"SRGameOverBoardLayer" fontName:@"Marker Felt" fontSize:32];
        [self addChild:label];
        label.position = ccp(100, 100);
        [self saveCurrentScore:15 withName:@"text"];
	}
	return self;
}

-(void) initMenuContent
{
    [self initMenu];
    [self initButtonMenu];
    [self initBackButton];
    [self initPlayAgainButton];
}

-(void) initMenu
{
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"titleYourFinalScore.png" selectedImage:@"titleYourFinalScore.png"];
    title.scale = 0.5;
    title.position = ccp([UIScreen mainScreen].bounds.size.height/2, 260);
    
    CCMenuItem *bestScore = [CCMenuItemFont itemWithString:@"100"];
    bestScore.position = ccp([UIScreen mainScreen].bounds.size.height/2, 200);
    
    CCMenu* menu = [CCMenu menuWithItems:title, bestScore, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zMenu tag:kTagMenu];
}

-(void) saveCurrentScore: (int)score withName: (NSString*)name
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    User *currentUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    currentUser.name = name;
    currentUser.score = [NSNumber numberWithInt:score];
    
    [app saveContext];
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    int i = 0;
    for (User *info in fetchedObjects){
        i++;
        if (info == currentUser) {
            NSLog(@"yyyyy%d", i);
            break;
        }
    }
    
}

@end
