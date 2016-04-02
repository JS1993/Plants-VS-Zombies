//
//  ZombB.m
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ZombB.h"

@implementation ZombB

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombIamge=[UIImage imageNamed:@"zomb_1"];
        self.speed=0.8;
        self.HP=5;
        self.oldSpeed=self.speed;
    }
    return self;
}

@end
