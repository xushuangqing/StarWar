//
//  SRContactListener.h
//  StarWar
//
//  Created by XuShuangqing on 14-4-18.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "CCPhysicsSprite.h"

class SRContactListener:public b2ContactListener
{
    virtual void BeginContact(b2Contact *contact);
};
