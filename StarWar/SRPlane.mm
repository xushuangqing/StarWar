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

-(void) createBodyForWorld:(b2World *)world withGeocentric:(b2Vec2)geocentric withPosition:(b2Vec2)position withLinearVelocity:(b2Vec2)linearVelocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.userData = @"plane";
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
@end
