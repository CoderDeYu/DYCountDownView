//
//  SecViewController.m
//  DYCountDownViewDemo
//
//  Created by 邓德宇 on 2017/9/29.
//  Copyright © 2017年 dengdeyu. All rights reserved.
//

#import "SecViewController.h"
#import "DYCountDownView.h"
@interface SecViewController ()

@property (strong, nonatomic) DYCountDownView *countDownView;


@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DYCountDownView *countDownView = [[DYCountDownView alloc]init];
    //传入秒数
    countDownView.calculationTime = 3600;
    //开启log
    [countDownView logOpen:YES];
    //设置位置
    [countDownView layoutSubviews];
    countDownView.center = self.view.center;
    [self.view addSubview:countDownView];
    self.countDownView = countDownView;
}
- (void)dealloc
{
    NSLog(@"控制器销毁了");
}


@end
