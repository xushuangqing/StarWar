//
//  SRMenuLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-16.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRMenuLayer.h"
#import "SRConstants.h"
#import "SRMainMenuLayer.h"
#import "SRSpaceLayer.h"
#import "AppDelegate.h"
#import "Score.h"

@implementation SRMenuLayer

- (id)init
{
    if( (self=[super init])) {
        [self initBackground];
	}
	return self;
}

- (void)initBackground
{
    [self initBackgroundColor];
    [self initBackgroundEarth];
}

- (void)initBackgroundColor
{
    CCLayerColor *darkBlue = [CCLayerColor layerWithColor:menuBackgroundColor];
    [self addChild:darkBlue z:zBackgroundColor tag:kTagBackgroundColor];
}

- (void)initBackgroundEarth
{
    CCSprite *backgroundEarth = [CCSprite spriteWithFile:@"backgroundEarth@2x.png"];
    backgroundEarth.anchorPoint = ccp(0, 0);
    backgroundEarth.position = ccp(0, 0);
    [self addChild:backgroundEarth z:zBackgroundEarth tag:kTagBackgroundEarth];
}

- (void)initButtonMenu
{
    CCMenu* menu = [CCMenu menuWithItems: nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zButtonMenu tag:kTagButtonMenu];
}





- (void)backToMainMenu:(id)sender
{
    [self buttonPressed:sender];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRMainMenuLayer scene]]];
}

- (void)playAgain: (id)sender
{
    [self buttonPressed:sender];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceLayer scene]]];
}

- (NSArray *)dataFetchRequest
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
    
    [sortDescriptors release];
    [sortDescriptor release];
    
    return fetchedObjects;
}

- (void)buttonPressed:(id)sender
{
    CCMenuItem *menuItem = (CCMenuItem*) sender;
    menuItem.position = ccp(menuItem.position.x-2, menuItem.position.y-2);
}

@end
