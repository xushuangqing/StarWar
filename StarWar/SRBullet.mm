//
//  SRBullet.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-19.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRBullet.h"
#import "SRConstants.h"

@implementation SRBullet

-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withVelocity:(b2Vec2)velocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = position;
    bodyDef.fixedRotation = YES;
    bodyDef.userData = @"bullet";
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2CircleShape dynamicBox;
    dynamicBox.m_radius = 0.1f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    body->CreateFixture(&fixtureDef);
    
    body->SetLinearVelocity(velocity);
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
}



@end
