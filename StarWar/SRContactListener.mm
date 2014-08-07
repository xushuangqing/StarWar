//
//  SRContactListener.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-18.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRContactListener.h"
#import "SRConstants.h"
#import "SRPlane.h"
#import "SRSpaceShip.h"
#import "SREarth.h"
#import "SRStar.h"
#import <typeinfo>

//@implementation SRContactListener

void SRContactListener::BeginContact(b2Contact *contact)
{
    
    id spriteA = (NSString*)contact->GetFixtureA()->GetBody()->GetUserData();
    id spriteB = (NSString*)contact->GetFixtureB()->GetBody()->GetUserData();

    if (([spriteA isKindOfClass:[SRSpaceShip class]] && [spriteB isKindOfClass:[SREarth class]]) || ([spriteB isKindOfClass:[SRSpaceShip class]] && [spriteA isKindOfClass:[SREarth class]])) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameSpaceShipDown object:nil];
    }
    
    if (([spriteA isKindOfClass:[SRSpaceShip class]] && [spriteB isKindOfClass:[SRPlane class]]) || ([spriteB isKindOfClass:[SRSpaceShip class]] && [spriteA isKindOfClass:[SRPlane class]])) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameSpaceShipTouchPlane object:nil];
    }

    if (([spriteA isKindOfClass:[SRSpaceShip class]] && [spriteB isKindOfClass:[SRStar class]]) || ([spriteB isKindOfClass:[SRSpaceShip class]] && [spriteA isKindOfClass:[SRStar class]])) {
        NSLog(@"touched");
    }
}


//@end
