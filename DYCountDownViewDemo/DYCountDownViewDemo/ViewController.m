//
//  ViewController.m
//  DYCountDownViewDemo
//
//  Created by 邓德宇 on 2017/9/29.
//  Copyright © 2017年 dengdeyu. All rights reserved.
//

#import "ViewController.h"
#import "DYCountDownView.h"
#import "SecViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化倒数View
    DYCountDownView *countDownView = [[DYCountDownView alloc]init];
    //传入秒数
    countDownView.calculationTime = 3600;
    //设置文字大小
    countDownView.labelFont = [UIFont systemFontOfSize:28];
    countDownView.sepFont = [UIFont systemFontOfSize:26];
    //设置文字背景
    countDownView.numberBackgroudColor = [UIColor grayColor];
    countDownView.sepBackgroupColor = [UIColor whiteColor];
    //设置文字的颜色
    countDownView.labelColor = [UIColor whiteColor];
    countDownView.sepColor = [UIColor blackColor];
    //设置位置
    countDownView.center = self.view.center;
    //添加View
    [self.view addSubview:countDownView];
}


- (IBAction)pushToSecViewController:(id)sender {
    [self.navigationController pushViewController:[[SecViewController alloc]init] animated:YES];
}

@end
