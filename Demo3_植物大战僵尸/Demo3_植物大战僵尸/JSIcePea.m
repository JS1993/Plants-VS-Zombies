//
//  JSIcePea.m
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSIcePea.h"

@implementation JSIcePea
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plantImage=[UIImage imageNamed:@"plant_3"];
        self.bulletImage=[UIImage imageNamed:@"bullet_1"];
        self.heat=2;
    }
    return self;
}

@end
