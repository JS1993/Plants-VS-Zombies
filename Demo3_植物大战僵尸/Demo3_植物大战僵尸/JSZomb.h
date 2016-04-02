//
//  JSZomb.h
//  Demo2_jiangshi
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "JSPlant.h"
@interface JSZomb : UIImageView
@property(nonatomic)int count;
@property(nonatomic)int HP;
@property(nonatomic)int heat;
@property(nonatomic,strong)UIImage* zombIamge;
@property(nonatomic)float speed;
@property(nonatomic)float oldSpeed;
@property(nonatomic,strong)NSTimer* changeImagetimer;
@property(nonatomic,weak)ViewController* VCDelegate;
@property(nonatomic)int failCount;
-(void)eat:(JSPlant*)plant;
-(void)dead;
@end
