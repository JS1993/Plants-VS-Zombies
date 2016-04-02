//
//  ViewController.h
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong,nonatomic)NSMutableArray* zombs;
@property(strong,nonatomic)NSMutableArray* plants;
@property (strong, nonatomic) IBOutlet UILabel *escapeCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *remainCountLabel;
@property(nonatomic)int remainCount;
-(void)addSunCount:(int)suncount;
-(void)rePlay;
@end

