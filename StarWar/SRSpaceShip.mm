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
@property b2Vec2 geocentric;
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
    bodyDef.userData = @"spaceShip";
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2CircleShape dynamicBox;
    dynamicBox.m_radius = 0.5f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 1.0f;//It is a test value
    body->CreateFixture(&fixtureDef);

    body->SetLinearVelocity(velocity);

    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
    [self setGeocentric:geocentric];
}

-(void) update:(ccTime)delta {
    
    
    /* For test, I make the spaceShip go around the point (5, 0) */

    float R2 = ((self.b2Body->GetPosition()).x-[self geocentric].x)*((self.b2Body->GetPosition()).x-[self geocentric].x) + (self.b2Body->GetPosition()).y*(self.b2Body->GetPosition()).y;
    float R = sqrt(R2);
    
    b2Vec2 force(-5.0/R2*((self.b2Body->GetPosition()).x-[self geocentric].x)/R,-5.0/R2*(self.b2Body->GetPosition()).y/R);
    
    self.b2Body->ApplyForce(force, self.b2Body->GetWorldCenter());
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

@end
