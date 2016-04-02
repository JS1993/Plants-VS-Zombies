//
//  JSPea.m
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSPea.h"

@implementation JSPea
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.plantImage=[UIImage imageNamed:@"plant_2"];
//        self.bulletImage=[UIImage imageNamed:@"bullet_0"];
//        self.bullets=[NSMutableArray array];
//    }
//    return self;
//}
//-(void)beganFire{
//    
//    self.buttleTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shout:) userInfo:nil repeats:YES];
//}
//-(void)shout:(NSTimer*)timer{
//    if (self.superview) {
//    UIImageView *fireImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.superview.center.x+7, self.superview.center.y-14, 10, 10)];
//    fireImageView.image=self.bulletImage;
//    [self.bullets addObject:fireImageView];
//    [self.VC.view addSubview:fireImageView];
//    CGPoint p=CGPointMake(self.VC.view.bounds.size.width, self.superview.center.y);
//用动画会导致动画执行完成之后再进行碰撞检测，只能销毁最末尾的僵尸
//    [UIView animateWithDuration:3 animations:^{
//        fireImageView.center=p;
//    } completion:^(BOOL finished) {
//        [fireImageView removeFromSuperview];
//        [self.bullets removeObject:fireImageView];
//    }];
//    }else {
//        [self.buttleTimer invalidate];
//    }
//}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plantImage = [UIImage imageNamed:@"plant_2"];
        self.bulletImage = [UIImage imageNamed:@"bullet_0.png"];
        self.bullets = [NSMutableArray array];
        self.heat=1;
    }
    return self;
}
-(void)beganFire{
    self.buttleTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addBullet:) userInfo:nil repeats:YES];
}
-(void)addBullet:(NSTimer*)timer{
    if(self.superview){
    UIImageView *bulletIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.superview.center.x+12, self.superview.center.y-16, 15, 15)];
    bulletIV.image = self.bulletImage;
    [self.VC.view addSubview:bulletIV];
    [self.bullets addObject:bulletIV];
    }else{
        [timer invalidate];
    }
}
-(void)changeImage:(NSTimer *)timer{
    [super changeImage:timer];
    
    for (UIImageView *bulletIV in self.bullets) {
        bulletIV.center = CGPointMake(bulletIV.center.x+7, bulletIV.center.y);
        //当子弹移除界面的时候删除
        if (bulletIV.center.x>568+bulletIV.bounds.size.width/2) {
            [bulletIV removeFromSuperview];
            [self.bullets removeObject:bulletIV];
            break;
        }
    }
}

-(void)dead{
    [self removeFromSuperview];
    [self.buttleTimer invalidate];
    //当花消失，子弹也随着消失
    for (UIImageView *bulletIV in self.bullets) {
        [bulletIV removeFromSuperview];
    }
    
}

@end
