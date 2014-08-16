//
//  SRStar.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-18.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRStar.h"
#import "SRConstants.h"

@implementation SRStar

- (void)createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = position;
    bodyDef.userData = self;
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2CircleShape dynamicBox;
    dynamicBox.m_radius = 0.5f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 0.0001f;//It is a test value
    body->CreateFixture(&fixtureDef);
    
    b2Filter filter;
    filter.maskBits = MaskBitsStar;
    filter.categoryBits = CategoryBitsStar;
    
    body->SetAngularVelocity(1);

    for (b2Fixture* fixture=body->GetFixtureList(); fixture; fixture=fixture->GetNext()) {
        fixture->SetFilterData(filter);
        fixture->SetDensity(0.1);
    }
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
}

- (void)touched
{
    [self setMaskBitsZero];
    [self hitByLaserAnimation];
    [self scheduleOnce:@selector(removeSelf) delay:1];
}

- (void)setMaskBitsZero
{
    b2Filter filter;
    for (b2Fixture* fixture=self.b2Body->GetFixtureList(); fixture; fixture=fixture->GetNext()) {
        filter = fixture->GetFilterData();
        filter.maskBits = 0x0000;
        fixture->SetFilterData(filter);
    }
}

- (void)hitByLaserAnimation
{
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1];
    [self runAction:[CCSequence actions:fadeOut, nil]];
}

- (void)removeSelf
{
    (self.b2Body->GetWorld())->DestroyBody(self.b2Body);
    [[self parent] removeChild:self];
}

@end
