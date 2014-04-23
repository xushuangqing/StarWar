//
//  SRAircraft.m
//  StarWar
//
//  Created by XuShuangqing on 14-4-23.
//  Copyright (c) 2014年 XuShuangqing. All rights reserved.
//

#import "SRAircraft.h"

@implementation SRAircraft

-(void) update:(ccTime)delta {
    
    float R2 = ((self.b2Body->GetPosition()).x-_geocentric.x)*((self.b2Body->GetPosition()).x-_geocentric.x) + (self.b2Body->GetPosition()).y*(self.b2Body->GetPosition()).y;
    float R = sqrt(R2);
    
    b2Vec2 force(-10.0/R2*((self.b2Body->GetPosition()).x-_geocentric.x)/R,-10.0/R2*(self.b2Body->GetPosition()).y/R);
    
    self.b2Body->ApplyForce(force, self.b2Body->GetWorldCenter());
}

@end
