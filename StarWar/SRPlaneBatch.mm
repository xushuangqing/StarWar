//
//  SRPlaneBatch.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-22.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRPlaneBatch.h"
#import "SRConstants.h"
#import "SRPlane.h"

@interface SRPlaneBatch ()
{
    b2World* _world;
    b2Vec2 _geocentric;
}

@end

@implementation SRPlaneBatch


-(void)createPlaneBatchForWorld: (b2World *)world withGeocentric: (b2Vec2)geocentric
{
    _world = world;
    [self schedule:@selector(addPlane) interval:1];
    [self scheduleUpdate];
    _geocentric = geocentric;
}

-(b2Vec2) linearVelocityForCircularMotionWithPosition: (b2Vec2)position
{
    float sqrRadius = powf((position.x-_geocentric.x), 2) + powf((position.y-_geocentric.y), 2);
    float radius = sqrtf(sqrRadius);
    float velocity = sqrtf(GM/radius);
    
    float velocityX = -velocity/radius*(position.y-_geocentric.y);
    float velocityY = velocity/radius*(position.x-_geocentric.x);
    
    b2Vec2 velocityVec(velocityX, velocityY);
    return velocityVec;
}

-(void)addPlane
{
    SRPlane* plane = [SRPlane node];
    
    float y = ((float)rand()/RAND_MAX)*[UIScreen mainScreen].bounds.size.width;
    CGPoint ccpPosition = [self convertToNodeSpace:ccp([UIScreen mainScreen].bounds.size.height, y)];
    
    b2Vec2 position(ccpPosition.x/PTM_RATIO, ccpPosition.y/PTM_RATIO);
    b2Vec2 velocity = [self linearVelocityForCircularMotionWithPosition:position];
    [plane createBodyForWorld:_world withGeocentric:_geocentric withPosition:position withLinearVelocity:velocity];
    [self addChild:plane];
}

@end
