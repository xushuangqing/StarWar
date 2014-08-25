//
//  SRPlane.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRPlane.h"
#import "SRConstants.h"
#import "GB2ShapeCache.h"

@implementation SRPlane

- (id)initWithTexture:(CCTexture2D *)texture
{
    if (self = [super initWithTexture:texture]) {
        _isAlive = YES;
    }
    return self;
}

- (void)createBodyForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric withPosition:(b2Vec2)position withLinearVelocity:(b2Vec2)linearVelocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.userData = self;
    bodyDef.position = position;
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:@"plane"];
    
    b2Filter filter;
    filter.maskBits = MaskBitsPlane;
    filter.categoryBits = CategoryBitsPlane;
    
    for (b2Fixture* fixture=body->GetFixtureList(); fixture; fixture=fixture->GetNext()) {
        fixture->SetFilterData(filter);
        fixture->SetDensity(0.1);
    }

    body->SetLinearVelocity(linearVelocity);
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
    _geocentric = geocentric;
}

- (void)update:(ccTime)delta
{
    [super update:delta];
    
    float tanAngle = (self.b2Body->GetPosition().x-_geocentric.x)/(self.b2Body->GetPosition().y-_geocentric.y);
    float angle = atan(tanAngle);
    angle = CC_RADIANS_TO_DEGREES(angle);
    
    if ((self.b2Body->GetPosition().y-_geocentric.y)<0) {
        angle = 180+angle;
    }
    self.rotation = -angle;
}

- (void)hitByLaser
{
    _isAlive = NO;
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
    CCFadeIn *action1 = [CCFadeIn actionWithDuration:0.1];
    CCFadeOut *action2 = [CCFadeOut actionWithDuration:0.1];
    [self runAction:[CCSequence actions:action1, action2, action1, action2, nil]];
}

- (void)removeSelf
{
    (self.b2Body->GetWorld())->DestroyBody(self.b2Body);
    [[self parent] removeChild:self];
}

@end
