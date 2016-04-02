//
//  JSPlant.m
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSPlant.h"

@implementation JSPlant
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.HP=50;
        self.plantTimer=[NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(changeImage:) userInfo:nil repeats:YES];
    }
    return self;
}
-(void)changeImage:(NSTimer*)timer{
    if(self.superview){
    CGImageRef subImage = CGImageCreateWithImageInRect(self.plantImage.CGImage, CGRectMake(self.count++%8*self.plantImage.size.width/8, 0, self.plantImage.size.width/8, self.plantImage.size.height));
    
    self.image = [UIImage imageWithCGImage:subImage];
    CGImageRelease(subImage);
    }else{
        [timer invalidate];
    }
}
-(void)dead{
//    [self removeFromSuperview];
//    [self.plantTimer invalidate];
}
-(void)beganFire{
    
}
-(void)dealloc{
    NSLog(@"植物死了");
}
@end
