//
//  ViewController.m
//  Demo3_植物大战僵尸
//
//  Created by  江苏 on 16/3/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "JSSunFlower.h"
#import "JSPlant.h"
#import "JSPea.h"
#import "JSIcePea.h"
#import "JSAnt.h"
#import "JSZomb.h"
#import "ZombA.h"
#import "ZombB.h"
#import "ZombC.h"
#import "ZombD.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *dragPlantsIVs;
@property(nonatomic,strong)JSPlant* dragPlant;
@property(nonatomic,strong)UIImageView* shovelImageV;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *boxViews;
@property (strong, nonatomic) IBOutlet UILabel *sunLabel;
@property(nonatomic)int zombCount;
@property(nonatomic)int holdCount;
@property(strong,nonatomic)NSTimer* crateZombTimer;
@end

@implementation ViewController
//设置选择植物的图片
-(void)initUI{
    UIImage* plantsImage=[UIImage imageNamed:@"seedpackets.png"];
    float w=plantsImage.size.width/18;
    for (int i=0;i<self.dragPlantsIVs.count;i++) {
        UIImageView* plantVs=self.dragPlantsIVs[i];
        int x=0;
        switch (plantVs.tag) {
            case 0:
                x=0;
                CGImageRef plantImage=CGImageCreateWithImageInRect(plantsImage.CGImage,CGRectMake(x, 0, w, plantsImage.size.height));
                plantVs.image=[UIImage imageWithCGImage:plantImage];
                break;
            case 1:
                x=1*w;
            {
                CGImageRef plantImage=CGImageCreateWithImageInRect(plantsImage.CGImage,CGRectMake(x, 0, w, plantsImage.size.height));
                plantVs.image=[UIImage imageWithCGImage:plantImage];
            }
                break;
            case 2:{
                x=3*w;
                CGImageRef plantImage=CGImageCreateWithImageInRect(plantsImage.CGImage,CGRectMake(x, 0, w, plantsImage.size.height));
                plantVs.image=[UIImage imageWithCGImage:plantImage];
            }
                break;
            case 3:
            {
                x=5*w;
                CGImageRef plantImage=CGImageCreateWithImageInRect(plantsImage.CGImage,CGRectMake(x, 0, w, plantsImage.size.height));
                plantVs.image=[UIImage imageWithCGImage:plantImage];
            }
                break;
//            case 4:
//                self.shovelImageV.image=[UIImage imageNamed:@"shovel.png"];
//                break;
            default:
                break;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.zombs=[NSMutableArray array];
    self.plants=[NSMutableArray array];
    self.holdCount=self.escapeCountLabel.text.intValue;
    self.remainCount=self.remainCountLabel.text.intValue;
    //创建僵尸
    self.crateZombTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(createZomb) userInfo:nil repeats:YES];
    //子弹的碰撞检测
    [NSTimer scheduledTimerWithTimeInterval:1/30 target:self selector:@selector(crashTest:) userInfo:nil repeats:YES];
    //僵尸吃植物检测
    [NSTimer scheduledTimerWithTimeInterval:1/30 target:self selector:@selector(eatPlantAction) userInfo:nil repeats:YES];
}
-(void)eatPlantAction{
    for(JSZomb* zomb in self.zombs){
        for (JSPlant* plant in self.plants) {
            if (CGRectContainsPoint(plant.superview.frame, zomb.center)) {
                if (zomb.speed!=0) {
                [zomb eat:plant];
                }
            }
        }
    }
}
-(void)crashTest:(NSTimer*)timer{
    for (JSZomb* zomb in self.zombs) {
        for (JSPlant* plant in self.plants) {
            //找到带有子弹的植物
            if ([plant isMemberOfClass:[JSPea class]]) {
                JSPea* pea=(JSPea*)plant;
                for (UIImageView* buttle in pea.bullets) {
                    //判断子弹和僵尸是不是重合
                    if (CGRectIntersectsRect(buttle.frame, zomb.frame)) {
                        //在数组中删除子弹
                        [buttle removeFromSuperview];
                        [pea.bullets removeObject:buttle];
                        //在视图中删除僵尸
                        zomb.HP=zomb.HP-pea.heat;
                        if (zomb.HP<=1) {
                            self.holdCount++;
                            [zomb dead];
                            [self.zombs removeObject:zomb];
                        }
                        return;
                    }
                }
            }else if ([plant isMemberOfClass:[JSIcePea class]]){
                JSIcePea* pea=(JSIcePea*)plant;
                for (UIImageView* buttle in pea.bullets) {
                    //判断子弹和僵尸是不是重合
                    if (CGRectIntersectsRect(buttle.frame, zomb.frame)) {
                        if(zomb.alpha==1){
                        //被寒冰射手击中，速度降低
                        zomb.speed*=0.5;
                        zomb.alpha=0.5;
                        }
                        //在数组中删除子弹
                        [buttle removeFromSuperview];
                        [pea.bullets removeObject:buttle];
                        //在视图中删除僵尸
                        zomb.HP=zomb.HP-pea.heat;
                        if (zomb.HP--<=1) {
                            self.holdCount++;
                            [zomb dead];
                            [self.zombs removeObject:zomb];
                        }
                        return;
                    }
                }
            }else if ([plant isMemberOfClass:[JSAnt class]]){
                JSAnt* ant=(JSAnt*)plant;
                if (CGRectIntersectsRect(ant.frame, zomb.frame)) {
                    zomb.HP=zomb.HP-ant.heat;
                    [ant removeFromSuperview];
                    [self.plants removeObject:ant];
                    if (zomb.HP--<=1) {
                        [zomb dead];
                        [self.zombs removeObject:zomb];
                    }
                    return;
                }
            }else if ([plant isMemberOfClass:[JSSunFlower class]]){
                JSSunFlower* sunflower=(JSSunFlower*)plant;
                if (CGRectIntersectsRect(sunflower.frame, zomb.frame)) {
                    zomb.HP=zomb.HP-sunflower.heat;
                    [sunflower removeFromSuperview];
                    [self.plants removeObject:sunflower];
                    if (zomb.HP--<=1) {
                        [zomb dead];
                        [self.zombs removeObject:zomb];
                    }
                    return;
                }
            }
         }
    }
    self.escapeCountLabel.text=[NSString stringWithFormat:@"%d",self.holdCount];
}
-(void)createZomb{
    int i=arc4random()%4;
    JSZomb* zomb=nil;
    switch (i) {
        case 0:
            zomb=[[ZombA alloc]initWithFrame:CGRectMake(568, arc4random()%5*50+50, 30, 50)];
            break;
        case 1:
            zomb=[[ZombB alloc]initWithFrame:CGRectMake(568, arc4random()%5*50+50, 30, 50)];
            break;
        case 2:
            zomb=[[ZombC alloc]initWithFrame:CGRectMake(568, arc4random()%5*50+50, 30, 50)];
            break;
        case 3:
            zomb=[[ZombD alloc]initWithFrame:CGRectMake(568, arc4random()%5*50+50, 30, 50)];
            break;
        default:
            break;
    }
    zomb.VCDelegate=self;
    //将新创建的僵尸加入数组中
    [self.zombs addObject:zomb];
    [self.view addSubview:zomb];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    CGPoint p=[touch locationInView:self.view];
    for(UIImageView* plantVS in self.dragPlantsIVs) {
        if (CGRectContainsPoint(plantVS.frame, p)) {
            switch (plantVS.tag) {
                case 0:
                    if (self.sunLabel.text.intValue>=50) {
                    self.dragPlant=[[JSSunFlower alloc]initWithFrame:plantVS.frame];
                        //把扣费写在这里，会导致放入不成功也会扣费，在花钱处就不会了
//                    self.sunLabel.text=[NSString stringWithFormat:@"%d",self.sunLabel.text.intValue-50];
                    }
                    break;
                case 1:
                    if (self.sunLabel.text.intValue>=100) {
                    self.dragPlant=[[JSPea alloc]initWithFrame:plantVS.frame];
                    }
                    break;
                case 2:
                    if (self.sunLabel.text.intValue>=175) {
                    self.dragPlant=[[JSIcePea alloc]initWithFrame:plantVS.frame];
                    }
                    break;
                case 3:
                    if (self.sunLabel.text.intValue>=125) {
                    self.dragPlant=[[JSAnt alloc]initWithFrame:plantVS.frame];
                    }
                    break;
                case 4:
                    self.shovelImageV=[[UIImageView alloc]initWithFrame:plantVS.frame];
                    self.shovelImageV.image=[UIImage imageNamed:@"shovel.png"];
                    [self.view addSubview:self.shovelImageV];
                default:
                    break;
            }
            self.dragPlant.tag=plantVS.tag; 
            self.dragPlant.VC=self;
            [self.view addSubview:self.dragPlant];
        }
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    CGPoint p=[touch locationInView:self.view];
    self.dragPlant.center=p;
    if (self.shovelImageV) {
        self.shovelImageV.center=p;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    CGPoint p=[touch locationInView:self.view];
    if (self.dragPlant) {
        for (UIView* box in self.boxViews) {
            if (CGRectContainsPoint(box.frame, p)&&box.subviews.count==0) {
                [box addSubview:self.dragPlant];
                //将新放下的植物加入数组当中
                [self.plants addObject:self.dragPlant];
                self.dragPlant.center=CGPointMake(box.bounds.size.width/2, box.bounds.size.height/2);
                //开火
                [self.dragPlant beganFire];
                //花钱
                int plantCount=-50;
                switch (self.dragPlant.tag) {
                    case 1:
                        plantCount=-100;
                        break;
                    case 2:
                        plantCount=-175;
                        break;
                    case 3:
                        plantCount=-125;
                        break;
                    default:
                        break;
                }
                [self addSunCount:plantCount];
            }
            if([self.dragPlant.superview isEqual:self.view ]){
                [ self.dragPlant removeFromSuperview];
            }
        }
        self.dragPlant=nil;
    }
    if (self.shovelImageV) {
        for (UIView* box in self.boxViews) {
                if (CGRectContainsPoint(box.frame, p)) {
                    //删除植物
                    for (JSPlant *plant in box.subviews) {
                        [plant dead];
                        //要将植物从数组中删除，否则内存释放不了
                        [self.plants removeObject:plant];
                        }
                    }
                [self.shovelImageV removeFromSuperview];
      }
        self.shovelImageV=nil;
    }
}
-(void)addSunCount:(int)suncount{
   int count=self.sunLabel.text.intValue;
    self.sunLabel.text=[NSString stringWithFormat:@"%d",count+suncount];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rePlay{
    [self.crateZombTimer invalidate];
    for (JSZomb* zomb in self.zombs) {
        [zomb dead];
    }
    for (JSPlant* plant in self.plants) {
        [plant dead];
    }
    [self.zombs removeAllObjects];
    [self.plants removeAllObjects];
    [self crateAlert];
}
-(void)crateAlert{
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"Game Over" message:@"僵尸吃掉了你的脑子" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction=[UIAlertAction actionWithTitle:@"开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.remainCount=10;
        self.holdCount=0;
        self.escapeCountLabel.text=[NSString stringWithFormat:@"%d",self.holdCount];
        self.remainCountLabel.text=[NSString stringWithFormat:@"%d",self.remainCount];
        self.sunLabel.text=@"3000";
        self.crateZombTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(createZomb) userInfo:nil repeats:YES];
        self.zombCount=0;
    }];
    UIAlertAction* cancelAction=[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //退出程序
        exit(0);
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
