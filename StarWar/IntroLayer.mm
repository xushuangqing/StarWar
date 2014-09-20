//
//  IntroLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright XuShuangqing 2014年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "SRMainMenuLayer.h"
#import "SRConstants.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init])) {
        CCLayerColor *backgroundColor = [CCLayerColor layerWithColor:menuBackgroundColor];
        [self addChild:backgroundColor z:zBackgroundColor];
		
        CCSprite *background;
        background = [CCSprite spriteWithFile:@"backgroundEarth@2x.png"];
        background.anchorPoint = ccp(0, 0);
        background.position = ccp(0, 0);

        [self addChild: background z:zControlLayer];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[SRMainMenuLayer scene]]];
}
@end
