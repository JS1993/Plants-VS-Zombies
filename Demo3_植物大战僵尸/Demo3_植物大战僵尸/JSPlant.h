//
//  JSPlant.h
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface JSPlant : UIImageView
@property(nonatomic,strong)UIImage* plantImage;
@property(nonatomic)int count;
@property(nonatomic)int times;
@property(nonatomic)int heat;
@property(nonatomic,weak)ViewController* VC;
@property(nonatomic,strong)UIImage* fireImage;
@property(nonatomic)int HP;
@property(nonatomic,strong)NSTimer* plantTimer;
-(void)beganFire;
-(void)changeImage:(NSTimer*)timer;
-(void)dead;
@end
