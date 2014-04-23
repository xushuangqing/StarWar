//
//  SRPlane.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRPlane.h"
#import "SRConstants.h"

@interface SRPlane ()
{
    b2Vec2 _geocentric;
}

@end

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

-(void) update:(ccTime)delta
{
    float R2 = ((self.b2Body->GetPosition()).x-_geocentric.x)*((self.b2Body->GetPosition()).x-_geocentric.x) + (self.b2Body->GetPosition()).y*(self.b2Body->GetPosition()).y;
    float R = sqrt(R2);
    
    b2Vec2 force(-10.0/R2*((self.b2Body->GetPosition()).x-_geocentric.x)/R,-10.0/R2*(self.b2Body->GetPosition()).y/R);
    
    self.b2Body->ApplyForce(force, self.b2Body->GetWorldCenter());
}

@end
