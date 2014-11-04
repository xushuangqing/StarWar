//
//  SREarth.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SREarth.h"
#import "SRConstants.h"

@implementation SREarth

- (id)initWithFile:(NSString *)filename
{
    if (self = [super initWithFile:filename]) {
        b2Vec2 center([[UIScreen mainScreen] bounds].size.height/PTM_RATIO/2, -8);
        [self setGeocentric:center];
    }
    return self;
}

- (void)createBodyForWorld:(b2World *)world withRadius:(float)radius withAngularVelocity:(float)angularVelocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    
    bodyDef.position = [self geocentric];
    bodyDef.userData = self;
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2CircleShape dynamicBox;
    dynamicBox.m_radius = radius;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    
    fixtureDef.filter.maskBits = MaskBitsEarth;
    fixtureDef.filter.categoryBits = CategoryBitsEarth;
    
    body->CreateFixture(&fixtureDef);
    
    body->SetAngularVelocity(angularVelocity);
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
}

@end
