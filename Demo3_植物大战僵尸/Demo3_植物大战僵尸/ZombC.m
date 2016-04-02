//
//  ZombC.m
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ZombC.h"

@implementation ZombC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombIamge=[UIImage imageNamed:@"zomb_2"];
        self.speed=1.0;
        self.HP=6;
        self.oldSpeed=self.speed;
    }
    return self;
}

@end
