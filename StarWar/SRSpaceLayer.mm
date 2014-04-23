//
//  SRSpaceLayer.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-12.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRSpaceLayer.h"
#import "SRSpaceShip.h"
#import "SRConstants.h"
#import "SRControlLayer.h"
#import "SREarth.h"
#import "SRStar.h"
#import "SRContactListener.h"

#import "SRBullet.h"
#import "SRBulletBatch.h"

#import "SRLaser.h"
#import "SRPlaneBatch.h"

@interface SRSpaceLayer(){
    b2World* _world;
    SRSpaceShip* _spaceShip;
    SREarth* _earth;
    SRStar *_star;
    SRLaser *_laser;
    GLESDebugDraw *m_debugDraw;
}
@end


@implementation SRSpaceLayer

+(CCScene *) scene
{
    //Create a new Scene which is the main scene of this game.
    CCScene *scene = [CCScene node];
    
    SRSpaceLayer *layer = [SRSpaceLayer node];
    [scene addChild: layer];
    
    SRControlLayer *controlLayer = [SRControlLayer node];
    [scene addChild:controlLayer];
    
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        [self initPhysics];
        [self initEarth];
        [self initSpaceShip];
        [self initStars];
        [self initLaser];
        [self initPlaneBatch];
        
        [self setAnchorPoint:ccp(0.5,PTM_RATIO*_earth.geocentric.y/[UIScreen mainScreen].bounds.size.width)];
        
        /* Only set scheduleUpdate, the update function can work*/
        [self scheduleUpdate];
    }
    return self;
}

-(void) initPhysics
{
    //Create the world
    b2Vec2 gravity(0,0);
    _world = new b2World(gravity);
    
    _world->SetAllowSleeping(true);
	_world->SetContinuousPhysics(true);
    
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
	_world->SetDebugDraw(m_debugDraw);

    m_debugDraw->SetFlags(b2Draw::e_shapeBit);
    
    SRContactListener *listener = new SRContactListener();
    _world->SetContactListener(listener);
}

-(void) initSpaceShip
{
    _spaceShip = [SRSpaceShip node];
    
    b2Vec2 position(2, 3);
    b2Vec2 velocity(0.7, 0.7);
    
    [_spaceShip createBodyForWorld:_world withPosition:position withGeocentric:_earth.geocentric withVelocity:velocity];
    
    [self addChild:_spaceShip];
}

-(void) initEarth
{
    _earth = [SREarth node];
    [_earth createBodyForWorld:_world withRadius:11.5f withAngularVelocity:0];
}

-(void) initStars
{
    _star = [SRStar node];
    b2Vec2 p(0,0);
    [_star createBodyForWorld:_world withPosition:p];
}

/*This function will not be used now*/
-(void) initBullets
{
    SRBulletBatch *bulletBatch = [SRBulletBatch batchNodeWithFile:@"blocks.png"];
    [bulletBatch createBulletBatchForWorld:_world withSpaceShip:_spaceShip];
    [self addChild:bulletBatch];
}

-(void) initLaser
{
    _laser = [SRLaser node];
    [_laser createBodyForWorld:_world withPosition:_spaceShip.b2Body->GetPosition() withRotation:0];
    [self addChild:_laser];
}

-(void) initPlaneBatch
{
    SRPlaneBatch* planeBatch = [SRPlaneBatch node];
    [planeBatch createPlaneBatchForWorld:_world withGeocentric:_earth.geocentric];
    [self addChild:planeBatch];
}

-(void) draw {
    [super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	_world->DrawDebugData();
	
	kmGLPopMatrix();
}

-(void) update: (ccTime) dt
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

    float angle = atan(([[UIScreen mainScreen] bounds].size.height/2-_spaceShip.position.x)/(_spaceShip.position.y-_earth.geocentric.y*PTM_RATIO));
    angle = CC_RADIANS_TO_DEGREES(angle);
    
    if ((_spaceShip.position.y-_earth.geocentric.y*PTM_RATIO) >= 0)
        [self setRotation:angle];
    else
        [self setRotation:180+angle];
    
    float velocityAngle = atan((_spaceShip.b2Body->GetLinearVelocity()).y/(_spaceShip.b2Body->GetLinearVelocity()).x);
    velocityAngle = CC_RADIANS_TO_DEGREES(velocityAngle);
    _laser.position = _spaceShip.position;
    
    if ((_spaceShip.b2Body->GetLinearVelocity()).x >= 0)
    {
        _laser.rotation = velocityAngle;
        _spaceShip.rotation = velocityAngle;
    }
    else
    {
        _laser.rotation = velocityAngle + 180;
        _spaceShip.rotation = velocityAngle + 180;
    }
    
    
}

-(void) dealloc
{
	delete _world;
	_world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}


@end
