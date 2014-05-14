//
//  SRScoreBoardLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-5-13.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRScoreBoardLayer.h"
#import "AppDelegate.h"
#import "User.h"

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

-(void) dataFetchRequest
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
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
        CCLabelTTF *label = [CCLabelTTF labelWithString:[[info score] stringValue] fontName:@"Marker Felt" fontSize:32];
        [self addChild:label];
        label.position = ccp(200, 320 - 30*i);
        i++;
        if(i>=10)
            break;
    }
}

@end
