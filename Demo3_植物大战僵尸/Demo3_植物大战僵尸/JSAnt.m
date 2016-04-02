//
//  JSAnt.m
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSAnt.h"

@implementation JSAnt
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plantImage=[UIImage imageNamed:@"plant_5"];
        self.HP=500;
        self.heat=0;
    }
    return self;
}
-(void)dead{
    [self removeFromSuperview];
}

@end
