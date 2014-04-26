//
//  SRStar.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright 2014年 XuShuangqing. All rights reserved.
//

#import "SRSpaceShip.h"
#import "SRConstants.h"

@interface SRSpaceShip ()

@end

@implementation SRSpaceShip

-(id) init
{
    if (self = [super init]) {
        [self registerNotification];
    }
    return self;
}

-(void) registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusVelocity:) name:NSNotificationNamePlusVelocity object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusVelocity:) name:NSNotificationNameMinusVelocity object:nil];
}

-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withGeocentric:(b2Vec2)geocentric withVelocity:(b2Vec2)velocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = position;
    bodyDef.fixedRotation = YES;
    bodyDef.userData = @"spaceShip";
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2CircleShape dynamicBox;
    dynamicBox.m_radius = 0.5f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 1.0f;//It is a test value
    
    fixtureDef.filter.maskBits = MaskBitsSpaceShit;
    fixtureDef.filter.categoryBits = CategoryBitsSpaceShip;
    
    body->CreateFixture(&fixtureDef);

    body->SetLinearVelocity(velocity);

    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
    _geocentric = geocentric;
}

-(void) plusVelocity: (NSNotification *) notification
{
    b2Vec2 v = self.b2Body->GetLinearVelocity();
    v.x = v.x * 1.1;
    v.y = v.y * 1.1;
    self.b2Body->SetLinearVelocity(v);
}

-(void) minusVelocity: (NSNotification *) notification
{
    b2Vec2 v = self.b2Body->GetLinearVelocity();
    v.x = v.x * 0.9;
    v.y = v.y * 0.9;
    self.b2Body->SetLinearVelocity(v);
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
