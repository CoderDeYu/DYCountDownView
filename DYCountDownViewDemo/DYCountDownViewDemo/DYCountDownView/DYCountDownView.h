//
//  MSCountdownView.h
//  Camp
//
//  Created by 邓德宇 on 2017/9/12.
//  Copyright © 2017年 meishakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYCountDownView;

@protocol DYCountDownViewDelegate <NSObject>

/**
 *  倒数结束后调用的方法
 */
- (void)countdownViewTimerInv:(DYCountDownView *)countdownView;

@end

@interface DYCountDownView : UIView

/**  秒数 */
@property (assign, nonatomic) NSInteger calculationTime;
/**  代理 */
@property (weak, nonatomic) id<DYCountDownViewDelegate>delegate;
/**  文字的font */
@property (strong, nonatomic) UIFont *labelFont;
/**  :的font */
@property (strong, nonatomic) UIFont *sepFont;
/**  数字的背景色 */
@property (strong, nonatomic) UIColor *numberBackgroudColor;
/**  :的背景色 */
@property (strong, nonatomic) UIColor *sepBackgroupColor;
/**  设置文字的颜色 */
@property (strong, nonatomic) UIColor *labelColor;
/**  :文字的颜色 */
@property (strong, nonatomic) UIColor *sepColor;

/**
 *  销毁定时器 ->不会触发代理
 */
- (void)invTimer;

@end
