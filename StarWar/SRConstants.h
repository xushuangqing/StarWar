//
//  SRConstant.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#define PTM_RATIO 32
#define NSNotificationNameSpaceShipDown @"spaceShipDown"
#define NSNotificationNameSpaceShitTouchStar @"spaceShipTouchStar"
#define NSNotificationNameSpaceShipTooFar @"spaceShipTooFar"
#define NSNotificationNameSpaceShipTouchPlane @"spaceShipTouchPlane"
#define NSNotificationNameScorePlus @"scorePlus"

#define SpaceShipAngelInView 15

#define ShieldTime 20

#define GM 10.0

#define CategoryBitsEarth 0x0001
#define CategoryBitsSpaceShip 0x0002
#define CategoryBitsLaser 0x0004
#define CategoryBitsPlane 0x0008
#define CategoryBitsStar 0x0010

#define MaskBitsEarth 0x0002
#define MaskBitsSpaceShip 0x0018
#define MaskBitsSpaceShipHasShield 0x0010
#define MaskBitsLaser 0x0000
#define MaskBitsPlane 0x0002
#define MaskBitsStar 0x0002




//below is the tag and z-index in space scene

#define zGameControlLayer 200
#define zControlLayer 100
#define zSpaceLayer 10
#define zBackgroundLayer 0

enum {
    kTagGameControlLayer = 1,
	kTagControlLayer = 2,
    kTagSpaceLayer = 3,
    kTagBackgroundLayer = 4,
};

#define zSpaceShip 100
#define zLaser 99

enum {
    kTagSpaceShip = 1,
    kTagLaser = 2,
};


//below is the tag and z-index in menu scene

#define zBackgroundColor 0
#define zBackgroundEarth 1
#define zMenu 2
#define zButtonMenu 3

enum {
    kTagBackgroundColor = 1,
    kTagBackgroundEarth = 2,
    kTagMenu = 3,
    kTagButtonMenu = 4,
};




#define LaserMaxWidth 640
#define LaserTextureWidth 64
#define LaserHeight 16
#define LaserTextureMovingSpeed -60

#define menuBackgroundColor ccc4(12, 33, 45, 255)
#define controlLayerBackgroundColor ccc3(0, 0, 0)

#define serverURL @"http://192.168.1.113:8000"
#define scoreURL  @"/api/1.0/score"
#define globleScoreURL @"/api/1.0/globle"

@interface SRConstants: NSObject

@end
