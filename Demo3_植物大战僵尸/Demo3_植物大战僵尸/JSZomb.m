//
//  JSZomb.m
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSZomb.h"
#import "JSPlant.h"
@implementation JSZomb
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.changeImagetimer=[NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(changeImage:) userInfo:nil repeats:YES];
    }
    return self;
}
-(void)changeImage:(NSTimer*)timer{
    //截取图片
    CGImageRef subImage=CGImageCreateWithImageInRect(self.zombIamge.CGImage, CGRectMake((self.count++%8)*self.zombIamge.size.width/8, 0, self.zombIamge.size.width/8, self.zombIamge.size.height));
    self.image=[UIImage imageWithCGImage:subImage];
    CGImageRelease(subImage);
    //初始位置
    self.center=CGPointMake(self.center.x-self.speed, self.center.y);
    if (self.center.x<=0) {
        self.VCDelegate.remainCount--;
        self.VCDelegate.remainCountLabel.text=[NSString stringWithFormat:@"%d",self.VCDelegate.remainCount];
        if (self.VCDelegate.remainCount<0) {
            [self.VCDelegate rePlay];
        }
        [self dead];
        [self.VCDelegate.zombs removeObject:self];
    }
}
-(void)dealloc{
    NSLog(@"僵尸销毁了");
}
-(void)dead{
    [self removeFromSuperview];
    [self.changeImagetimer invalidate];
}
-(void)eat:(JSPlant*)plant{
    self.speed=0;
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(zombEatAction:) userInfo:plant repeats:YES];
}
-(void)zombEatAction:(NSTimer*)timer{
    JSPlant* plant=timer.userInfo;
    plant.HP--;
    if (plant.HP<0) {
        self.speed=self.oldSpeed;
        [plant dead];
        [self.VCDelegate.plants removeObject:self];
        
    }
}
@end
