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

#define GM 10.0

#define CategoryBitsEarth 0x0001
#define CategoryBitsSpaceShip 0x0002
#define CategoryBitsLaser 0x0004
#define CategoryBitsPlane 0x0008

#define MaskBitsEarth 0x0002
#define MaskBitsSpaceShit 0x0009
#define MaskBitsLaser 0x0000
#define MaskBitsPlane 0x0006


@interface SRConstants: NSObject

@end
