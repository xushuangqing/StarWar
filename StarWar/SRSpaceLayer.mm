//
//  SRSpaceLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "GB2ShapeCache.h"
#import "SRSpaceLayer.h"
#import "SRSpaceShip.h"
#import "SRConstants.h"
#import "SREarth.h"
#import "SRStar.h"
#import "SRContactListener.h"
#import "SRPlaneBatch.h"
#import "SRStarBatch.h"
#import "SRPlane.h"

@implementation SRSpaceLayer
{
    b2World *_world;
    SRSpaceShip *_spaceShip;
    SREarth *_earth;
    CCSprite *_fire;
    SRStarBatch *_starBatch;
    CCSprite *_laser;
    SRPlaneBatch* _planeBatch;

    //GLESDebugDraw *m_debugDraw;
    b2RayCastInput _input;
    b2RayCastOutput _output;

    SRContactListener *_listener;
}

- (id)init
{
    if (self = [super init]) {
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"physicsShape.plist"];

        [self initPhysics];

        [self initEarth];
        [self initSpaceShip];
        [self initFire];
        [self initStarBatch];
        [self initLaser];
        [self initPlaneBatch];
        
        [self setAnchorPoint:ccp(0.5,PTM_RATIO*_earth.geocentric.y/[UIScreen mainScreen].bounds.size.height)];
        
        /* Only set scheduleUpdate, the update function can work*/
        [self scheduleUpdate];
    }
    return self;
}

- (void)initPhysics
{
    //Create the world
    b2Vec2 gravity(0,0);
    _world = new b2World(gravity);
    
    _world->SetAllowSleeping(true);
	_world->SetContinuousPhysics(true);
    
    //m_debugDraw = new GLESDebugDraw(PTM_RATIO);
	//_world->SetDebugDraw(m_debugDraw);

    //m_debugDraw->SetFlags(b2Draw::e_shapeBit);
    
    _listener = new SRContactListener();
    _world->SetContactListener(_listener);
}

- (void)initSpaceShip
{
    _spaceShip = [SRSpaceShip spriteWithFile:@"spaceship@2x.png"];
    b2Vec2 position(2, 3);
    b2Vec2 velocity(0.7, 0.7);
    [_spaceShip createBodyForWorld:_world withPosition:position withGeocentric:_earth.geocentric withVelocity:velocity];
    [self addChild:_spaceShip z:zSpaceShip tag:kTagSpaceShip];
}

- (void)initFire
{
    _fire = [CCSprite spriteWithFile:@"fire@2x.png"];
    _fire.anchorPoint = ccp(1, 0.5);
    [self addChild:_fire];
}

- (void)initEarth
{
    _earth = [SREarth spriteWithFile:@"earth@2x.png"];
    [_earth createBodyForWorld:_world withRadius:11.3f withAngularVelocity:0];
    [self addChild:_earth];
}

- (void)initStarBatch
{
    _starBatch = [SRStarBatch batchNodeWithFile:@"red_star@2x.png"];
    [_starBatch createStarBatchForWorld:_world];
    [self addChild:_starBatch];
}

- (void)initLaser
{
    CGRect r = CGRectMake(0, 0, LaserMaxWidth, LaserHeight);
    _laser = [CCSprite spriteWithFile:@"laser@2x.png" rect:r];
    
    ccTexParams params = {
        GL_LINEAR,
        GL_LINEAR,
        GL_REPEAT,
        GL_REPEAT
    };
    [_laser.texture setTexParameters:&params];
    _laser.anchorPoint = ccp(-0.01, 0.5);
    [self addChild:_laser z:zLaser tag:kTagLaser];
}

- (void)initPlaneBatch
{
    _planeBatch = [SRPlaneBatch batchNodeWithFile:@"plane@2x.png"];
    [_planeBatch createPlaneBatchForWorld:_world withGeocentric:_earth.geocentric];
    [self addChild:_planeBatch];
}

- (void)stopSchedule
{
    for (CCNode* node in self.children) {
        [node unscheduleAllSelectors];
        [node unscheduleUpdate];
    }
    [self unscheduleAllSelectors];
    [self unscheduleUpdate];
}

- (void)spaceshipAccelerate
{
    [_spaceShip accelerate];
}

- (void)spaceshipDecelerate
{
    [_spaceShip decelerate];
}

- (void)pause
{
    for (CCNode* node in self.children) {
        [node pauseSchedulerAndActions];
    }
    [self pauseSchedulerAndActions];
}

- (void)resume
{
    for (CCNode* node in self.children) {
        [node resumeSchedulerAndActions];
    }
    [self resumeSchedulerAndActions];
}

- (void)draw {
    [super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	_world->DrawDebugData();
	
	kmGLPopMatrix();
}

- (void)update:(ccTime)dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	_world->Step(dt, velocityIterations, positionIterations);

    [self rotateSpaceLayer];
    [self updateSpaceShipDirection];

    [self destoryPlane:dt];
}

- (void)updateSpaceShipDirection
{
    float velocityAngle = atan((_spaceShip.b2Body->GetLinearVelocity()).y/(_spaceShip.b2Body->GetLinearVelocity()).x);
    velocityAngle = CC_RADIANS_TO_DEGREES(velocityAngle);
    _laser.position = _spaceShip.position;
    
    if ((_spaceShip.b2Body->GetLinearVelocity()).x >= 0)
    {
        _laser.rotation = -velocityAngle;
        _spaceShip.rotation = velocityAngle;
    }
    else
    {
        _laser.rotation = -velocityAngle - 180;
        _spaceShip.rotation = velocityAngle + 180;
    }

    _fire.position = CGPointMake((2*_fire.position.x+_spaceShip.position.x)/3, (2*_fire.position.y+_spaceShip.position.y)/3);
    _fire.rotation = -_spaceShip.rotation;

    float dis = sqrtf((_fire.position.x-_spaceShip.position.x)*(_fire.position.x-_spaceShip.position.x)+(_fire.position.y-_spaceShip.position.y)*(_fire.position.y-_spaceShip.position.y));
    _fire.scale = dis/60+1;
}

- (void)rotateSpaceLayer
{
    float angle = atan(([[UIScreen mainScreen] bounds].size.width/2-_spaceShip.position.x)/(_spaceShip.position.y-_earth.geocentric.y*PTM_RATIO));
    angle = CC_RADIANS_TO_DEGREES(angle);
    
    if ((_spaceShip.position.y-_earth.geocentric.y*PTM_RATIO) >= 0)
        [self setRotation:angle-SpaceShipAngelInView];
    else
        [self setRotation:180+angle-SpaceShipAngelInView];
}

- (void)destoryPlane:(ccTime)dt
{
    _input.p1 = _spaceShip.b2Body->GetPosition();
    _input.p2 = b2Vec2((_spaceShip.b2Body->GetPosition()).x+(_spaceShip.b2Body->GetLinearVelocity()).x, (_spaceShip.b2Body->GetPosition()).y+(_spaceShip.b2Body->GetLinearVelocity()).y);
    _input.maxFraction = MAXFLOAT;
    
    float minFraction = _input.maxFraction;
    SRPlane* touchedPlane = nil;
    
    for (SRPlane* plane in _planeBatch.children) {
        for (b2Fixture* fixture = plane.b2Body->GetFixtureList(); fixture; fixture = fixture->GetNext()) {
            if (fixture->RayCast(&_output, _input, 0)) {
                if (_output.fraction < minFraction) {
                    minFraction = _output.fraction;
                    touchedPlane = plane;
                }
            }
        }
    }
    
    static float offset = 0;
    offset += LaserTextureMovingSpeed * dt;
    if (offset <= -LaserTextureWidth) {
        offset += LaserTextureWidth;
    }

    if (touchedPlane && touchedPlane.isAlive) {
        [self scorePlus];
        [touchedPlane hitByLaser];
    }
    else if (touchedPlane) {
        float v = sqrtf(powf(_spaceShip.b2Body->GetLinearVelocity().x, 2.0f)+powf(_spaceShip.b2Body->GetLinearVelocity().y, 2.0f));
        
        CGRect r = CGRectMake(offset, 0, v*_output.fraction*PTM_RATIO, LaserHeight);
        [_laser setTextureRect:r];
    }
    else {
        CGRect r = CGRectMake(offset, 0, LaserMaxWidth, LaserHeight);
        [_laser setTextureRect:r];
    }
}

- (void)scorePlus
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNameScorePlus object:nil];
}

- (void)dealloc
{
    b2Body *body = _world->GetBodyList();
    for (; body; body = body->GetNext()) {
        _world->DestroyBody(body);
    }
    
	delete _world;
	_world = NULL;
    
    delete _listener;
    _listener = NULL;
	
	//delete m_debugDraw;
	//m_debugDraw = NULL;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[super dealloc];
}

@end
