//
//  ZombA.m
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ZombA.h"

@implementation ZombA

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombIamge=[UIImage imageNamed:@"zomb_0"];
        self.speed=3;
        self.HP=3;
        self.oldSpeed=self.speed;
    }
    return self;
}

@end
