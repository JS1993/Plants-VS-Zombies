//
//  JSSunFlower.m
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSSunFlower.h"

@implementation JSSunFlower
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plantImage=[UIImage imageNamed:@"plant_0"];
        self.heat=0;
    }
    return self;
}
-(void)beganFire{
    self.userInteractionEnabled=YES;
    self.plantTimer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addSun:) userInfo:nil repeats:YES];
}
-(void)addSun:(NSTimer*)timer{
    if (self.superview) {
    UIButton* sunButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [sunButton setImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
    [sunButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sunButton];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(remove:) userInfo:sunButton repeats:YES];
    }else{
        [timer invalidate];
    }
}
-(void)click:(UIButton*)btn{
    [self.VC addSunCount:25];
    [btn removeFromSuperview];
}
-(void)dead{
    [self removeFromSuperview];
    [self.plantTimer invalidate];
}
-(void)remove:(NSTimer*)timer{
    if (self.superview) {
    UIButton* btn=timer.userInfo;
    [btn removeFromSuperview];
    }else{
        [timer invalidate];
    }
}
@end
