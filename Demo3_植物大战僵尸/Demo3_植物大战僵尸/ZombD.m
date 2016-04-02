//
//  ZombD.m
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ZombD.h"

@implementation ZombD

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombIamge=[UIImage imageNamed:@"zomb_3"];
        self.speed=1.2;
        self.HP=7;
        self.oldSpeed=self.speed;
    }
    return self;
}

@end
