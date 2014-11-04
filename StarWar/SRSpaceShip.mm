//
//  SRStar.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright 2014年 XuShuangqing. All rights reserved.
//

#import "GB2ShapeCache.h"
#import "SRSpaceShip.h"
#import "SRConstants.h"

@implementation SRSpaceShip
{
    CCSprite *_shine;
    CCAction *_repeatedShiningAction;
}

- (id)initWithFile:(NSString *)filename
{
    if (self = [super initWithFile:filename]) {
        self.anchorPoint = ccp(0, 0.5);

        _shine = [CCSprite spriteWithFile:@"light1@2x.png"];
        _shine.anchorPoint = CGPointMake(0, 0.5);
        _shine.position = CGPointMake(0, 38);
        [self addChild:_shine];
        _shine.visible = NO;
        [self initShineAnimation];
    }
    return self;
}

- (void)createBodyForWorld:(b2World *)world withPosition:(b2Vec2)position withGeocentric:(b2Vec2)geocentric withVelocity:(b2Vec2)velocity
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = position;
    bodyDef.fixedRotation = YES;
    bodyDef.userData = self;
    
    b2Body *body = world->CreateBody(&bodyDef);

    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:@"spaceShip"];
    
    b2Filter filter;
    filter.maskBits = MaskBitsSpaceShip;
    filter.categoryBits = CategoryBitsSpaceShip;
    
    for (b2Fixture* fixture=body->GetFixtureList(); fixture; fixture=fixture->GetNext()) {
        fixture->SetFilterData(filter);
        fixture->SetDensity(0.1);
    }

    body->SetLinearVelocity(velocity);

    [self setPTMRatio:PTM_RATIO];
    [self setB2Body:body];
    [self scheduleUpdate];
    
    _geocentric = geocentric;
}

- (void)getShield
{
    _shine.visible = YES;
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.4];
    [_shine runAction:fadeIn];
    for (b2Fixture* fixture=self.b2Body->GetFixtureList(); fixture; fixture=fixture->GetNext()) {
        b2Filter filter = fixture->GetFilterData();
        filter.maskBits = MaskBitsSpaceShipHasShield;
        fixture->SetFilterData(filter);
    }
    [self scheduleOnce:@selector(shieldWillTimeOut) delay:ShieldTime];
}

- (void)shieldWillTimeOut
{
    CCFadeIn *action1 = [CCFadeIn actionWithDuration:0.1];
    CCFadeOut *action2 = [CCFadeOut actionWithDuration:0.1];
    [_shine runAction:[CCSequence actions:action1, action2, action1, action2, action1, action2, nil]];
    [self scheduleOnce:@selector(shieldDidTimeOut) delay:0.5];
}

- (void)shieldDidTimeOut
{
    _shine.visible = NO;
    for (b2Fixture* fixture=self.b2Body->GetFixtureList(); fixture; fixture=fixture->GetNext()) {
        b2Filter filter = fixture->GetFilterData();
        filter.maskBits = MaskBitsSpaceShip;
        fixture->SetFilterData(filter);
    }
}

- (void)initShineAnimation
{
    CCSpriteFrame *frame1 = [CCSpriteFrame frameWithTextureFilename:@"light1@2x.png" rect:CGRectMake(0, 0, 95, 107)];
    CCSpriteFrame *frame2 = [CCSpriteFrame frameWithTextureFilename:@"light2@2x.png" rect:CGRectMake(0, 0, 95, 107)];
    CCSpriteFrame *frame3 = [CCSpriteFrame frameWithTextureFilename:@"light3@2x.png" rect:CGRectMake(0, 0, 95, 107)];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:@[frame1, frame2, frame3] delay:0.1];
    CCAnimate *animate = [CCAnimate actionWithAnimation:animation];

    _repeatedShiningAction = [CCRepeatForever actionWithAction:animate];
    [_shine runAction:_repeatedShiningAction];
}

- (void)accelerate
{
    b2Vec2 v = self.b2Body->GetLinearVelocity();
    v.x = v.x * 1.1;
    v.y = v.y * 1.1;
    self.b2Body->SetLinearVelocity(v);
}

- (void)decelerate
{
    b2Vec2 v = self.b2Body->GetLinearVelocity();
    v.x = v.x * 0.9;
    v.y = v.y * 0.9;
    self.b2Body->SetLinearVelocity(v);
}

- (void)update:(ccTime)delta
{
    [super update:delta];
    CGPoint worldPosition = [self convertToWorldSpace:self.anchorPointInPoints];
    if (worldPosition.y > [UIScreen mainScreen].bounds.size.width+200 || worldPosition.y < -PTM_RATIO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameSpaceShipTooFar object:nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
