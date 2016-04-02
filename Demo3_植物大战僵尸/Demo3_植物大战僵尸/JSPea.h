//
//  JSPea.h
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSPlant.h"

@interface JSPea : JSPlant
@property(strong,nonatomic)UIImage* bulletImage;
@property(strong,nonatomic)NSMutableArray* bullets;
@property(strong,nonatomic)NSTimer* buttleTimer;
@end
