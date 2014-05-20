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

-(id) init
{
    if( (self=[super init])) {
        [self initMenuContent];
        [self initBackground];
	}
	return self;
}

-(void) initMenuContent
{
    
}

-(void) initBackground
{
    [self initBackgroundColor];
    [self initBackgroundEarth];
}

-(void) initBackgroundColor
{
    CCLayerColor *darkBlue = [CCLayerColor layerWithColor:menuBackgroundColor];
    [self addChild:darkBlue z:zBackgroundColor tag:kTagBackgroundColor];
}

-(void) initBackgroundEarth
{
    CCSprite *backgroundEarth = [CCSprite spriteWithFile:@"backgroundEarth.png"];
    backgroundEarth.scale = 0.5;
    backgroundEarth.anchorPoint = ccp(0, 0);
    backgroundEarth.position = ccp(0, 0);
    [self addChild:backgroundEarth z:zBackgroundEarth tag:kTagBackgroundEarth];
}

-(void) initButtonMenu
{
    CCMenu* menu = [CCMenu menuWithItems: nil];
    menu.position = CGPointZero;
    [self addChild:menu z:zButtonMenu tag:kTagButtonMenu];
}

-(void) initBackButton
{
    CCMenuItem *backButton = [CCMenuItemImage itemWithNormalImage:@"buttonMainMenu.png" selectedImage:@"buttonMainMenu.png" target:self selector:@selector(backToMainMenu)];
    backButton.scale = 0.5;
    backButton.anchorPoint = ccp(1, 0);
    backButton.position = ccp([UIScreen mainScreen].bounds.size.height, 0);
    
    CCMenu* menu = (CCMenu *)[self getChildByTag:kTagButtonMenu];
    [menu addChild:backButton];
}

-(void) initPlayAgainButton
{
    CCMenuItem *playAgainButton = [CCMenuItemImage itemWithNormalImage:@"buttonPlayAgain.png" selectedImage:@"buttonPlayAgain.png" target:self selector:@selector(playAgain)];
    playAgainButton .scale = 0.5;
    playAgainButton .anchorPoint = ccp(0, 0);
    playAgainButton .position = ccp(0, 0);
    
    CCMenu* menu = (CCMenu *)[self getChildByTag:kTagButtonMenu];
    [menu addChild:playAgainButton];
}

-(void) backToMainMenu
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRMainMenuLayer scene]]];
}

-(void) playAgain
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SRSpaceLayer scene]]];
}

-(NSArray *) dataFetchRequest
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

@end
