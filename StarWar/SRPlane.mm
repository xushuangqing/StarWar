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

-(void) createBodyForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric withPosition:(b2Vec2)position withLinearVelocity:(b2Vec2)linearVelocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.userData = @"plane";
    bodyDef.position = position;
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(.5, .5);
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 1.0f;//It is a test value
    fixtureDef.filter.maskBits = 0x0000;
    body->CreateFixture(&fixtureDef);
    
    body->SetLinearVelocity(linearVelocity);
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
    _geocentric = geocentric;
}
@end
