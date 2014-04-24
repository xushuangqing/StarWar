//
//  SRLaser.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRLaser.h"
#import "SRConstants.h"

@implementation SRLaser

-(void) createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withRotation:(float)rotation
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = position;
    bodyDef.fixedRotation = YES;
    bodyDef.userData = @"laser";
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    /*Set the shape of SpaceShip*/
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(10, .1);
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    
    fixtureDef.filter.maskBits = MaskBitsLaser;
    fixtureDef.filter.categoryBits = CategoryBitsLaser;
    
    
    body->CreateFixture(&fixtureDef);
    
    body->SetTransform(position, rotation);
    
    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
}


@end
