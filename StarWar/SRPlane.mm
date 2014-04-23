//
//  SRPlane.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRPlane.h"
#import "SRConstants.h"

@implementation SRPlane

-(void) createBodyForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.userData = @"plane";
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2CircleShape dynamicBox;
    dynamicBox.m_radius = 0.5f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 1.0f;//It is a test value
    body->CreateFixture(&fixtureDef);
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
    _geocentric = geocentric;
}
@end
