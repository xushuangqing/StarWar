//
//  SRContactListener.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-18.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRContactListener.h"
#import "SRConstants.h"
#import <typeinfo>

//@implementation SRContactListener

void SRContactListener::BeginContact(b2Contact *contact)
{
    
    NSString* spriteA = (NSString*)contact->GetFixtureA()->GetBody()->GetUserData();
    NSString* spriteB = (NSString*)contact->GetFixtureB()->GetBody()->GetUserData();
    
    if (([spriteA isEqual:@"spaceShip"] && [spriteB isEqual:@"earth"]) || ([spriteB isEqual:@"spaceShip"] && [spriteA isEqual:@"earth"])) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameSpaceShipDown object:nil];
    }
    
    if (([spriteA isEqual:@"spaceShip"] && [spriteB isEqual:@"plane"]) || ([spriteB isEqual:@"spaceShip"] && [spriteA isEqual:@"plane"])) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameSpaceShipDown object:nil];
    }
}


//@end
