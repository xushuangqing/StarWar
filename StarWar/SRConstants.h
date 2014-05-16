//
//  SRConstant.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-17.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#define PTM_RATIO 32
#define NSNotificationNamePlusVelocity @"plusVelocity"
#define NSNotificationNameMinusVelocity @"minusVelocity"
#define NSNotificationNameSpaceShipDown @"spaceShipDown"
#define NSNotificationNameSpaceShipTouchPlane @"spaceShipTouchPlane"

#define SpaceShipAngelInView 15

#define GM 10.0

#define CategoryBitsEarth 0x0001
#define CategoryBitsSpaceShip 0x0002
#define CategoryBitsLaser 0x0004
#define CategoryBitsPlane 0x0008

#define MaskBitsEarth 0x0002
#define MaskBitsSpaceShip 0x0008
#define MaskBitsLaser 0x0000
#define MaskBitsPlane 0x0002




//below is the tag and z-index in space scene

#define zControlLayer 100

enum {
	kTagControlLayer = 1,
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

enum {
    kTagBackgroundColor = 1,
    kTagBackgroundEarth = 2,
    kTagMenu = 3,
};




#define LaserMaxWidth 640
#define LaserHeight 16

#define menuBackgroundColor ccc4(12, 33, 45, 255)

@interface SRConstants: NSObject

@end
