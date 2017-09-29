//
//  dyCountdownView.m
//  Camp
//
//  Created by 邓德宇 on 2017/9/12.
//  Copyright © 2017年 meishakeji. All rights reserved.
//

#import "DYCountDownView.h"
//导入设置颜色分类
#import "UIColor+DYHex.h"
//导入设置位置分类
#import "UIView+DYFrame.h"

@interface DYCountDownView ()
/**  小时第一位数字 */
@property (strong, nonatomic) UILabel *hourFirstLabel;
/**  小时第二位数字 */
@property (strong, nonatomic) UILabel *hourSecondLabel;
/**  第一个分号 */
@property (strong, nonatomic) UILabel *firstSeparateLabel;
/**  分第一位数字 */
@property (strong, nonatomic) UILabel *minuteFirstLabel;
/**  分第二位数字 */
@property (strong, nonatomic) UILabel *minuteSecondLabel;
/**  第二个分号 */
@property (strong, nonatomic) UILabel *secondSeparateLabel;
/**  秒第一位数字 */
@property (strong, nonatomic) UILabel *secondsFirstLabel;
/**  秒第二位数字 */
@property (strong, nonatomic) UILabel *secondsSecondLabel;
/**  定时器 */
@property (strong, nonatomic) NSTimer *timer;
/**  当前时间 */
@property (assign, nonatomic) NSInteger currentTime;
/**  是否是进入了后台 */
@property (assign, nonatomic) BOOL isEndterToBackgroud;
@property (assign, nonatomic) NSInteger endterToBackgroudTime;

@end

@implementation DYCountDownView

/**
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

/**
 *  添加控件
 */
- (void)setUp
{
    //创建
    self.hourFirstLabel = [self addTimeLabel:28 backgroundColor:[UIColor colorWithHexString:@"eef1f3"] text:@"0"];
    self.hourSecondLabel = [self addTimeLabel:28 backgroundColor:[UIColor colorWithHexString:@"eef1f3"] text:@"0"];
    
    self.firstSeparateLabel = [self addTimeLabel:26 backgroundColor:[UIColor whiteColor] text:@":"];
    
    self.minuteFirstLabel = [self addTimeLabel:28 backgroundColor:[UIColor colorWithHexString:@"eef1f3"] text:@"0"];
    self.minuteSecondLabel = [self addTimeLabel:28 backgroundColor:[UIColor colorWithHexString:@"eef1f3"] text:@"0"];
    
    self.secondSeparateLabel = [self addTimeLabel:26 backgroundColor:[UIColor whiteColor] text:@":"];
    
    self.secondsFirstLabel = [self addTimeLabel:28 backgroundColor:[UIColor colorWithHexString:@"eef1f3"] text:@"0"];
    self.secondsSecondLabel = [self addTimeLabel:28 backgroundColor:[UIColor colorWithHexString:@"eef1f3"] text:@"0"];
    
    //添加监听进入后台和进入前台的监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEndterBackgroud) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEndterForward) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  添加控件方法
 */
- (UILabel *)addTimeLabel:(CGFloat)fontSize backgroundColor:(UIColor *)backgroundColor text:(NSString *)text
{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = backgroundColor;
    label.textColor = [UIColor colorWithHexString:@"515760"];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.layer.cornerRadius = [UIView getScaleHeightMeasureWithMeasure:2];
    label.layer.masksToBounds = YES;
    label.clipsToBounds = YES;
    [self addSubview:label];
    return label;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self setUpFrameWithLabel:self.hourFirstLabel];
    
    
    [self setUpFrameWithSepLabel:self.firstSeparateLabel];
    
    if (self.firstSeparateLabel.dyHeight > self.hourFirstLabel.dyHeight) {
        self.dyHeight = self.firstSeparateLabel.dyHeight;
    } else {
        self.dyHeight = self.hourFirstLabel.dyHeight;
    }
    
    [self setUpFrameWithLabel:self.hourFirstLabel];
    self.hourFirstLabel.dyX = 0;
    
    
    [self setUpFrameWithLabel:self.hourSecondLabel];
    self.hourSecondLabel.dyX = self.hourFirstLabel.dyWidth + [UIView getScaleWidthMeasureWithMeasure:2];
    
    [self setUpFrameWithSepLabel:self.firstSeparateLabel];
    self.firstSeparateLabel.dyX = self.hourSecondLabel.dyX + self.hourSecondLabel.dyWidth;
    
    [self setUpFrameWithLabel:self.minuteFirstLabel];
    self.minuteFirstLabel.dyX = self.firstSeparateLabel.dyX + self.firstSeparateLabel.dyWidth;
    
    [self setUpFrameWithLabel:self.minuteSecondLabel];
    self.minuteSecondLabel.dyX = self.minuteFirstLabel.dyX + self.minuteFirstLabel.dyWidth + [UIView getScaleWidthMeasureWithMeasure:2];
    
    [self setUpFrameWithSepLabel:self.secondSeparateLabel];
    self.secondSeparateLabel.dyX = self.minuteSecondLabel.dyX + self.minuteSecondLabel.dyWidth;
    
    [self setUpFrameWithLabel:self.secondsFirstLabel];
    self.secondsFirstLabel.dyX = self.secondSeparateLabel.dyX + self.secondSeparateLabel.dyWidth;
    
    [self setUpFrameWithLabel:self.secondsSecondLabel];
    self.secondsSecondLabel.dyX = self.secondsFirstLabel.dyX + self.secondsFirstLabel.dyWidth + [UIView getScaleWidthMeasureWithMeasure:2];
    
    self.dyWidth = self.secondsSecondLabel.dyX + self.secondsSecondLabel.dyWidth;
    
}

/**
 *  设置label的大小
 */
- (void)setUpFrameWithLabel:(UILabel *)label
{
    [label sizeToFit];
    label.dyWidth +=[UIView getScaleWidthMeasureWithMeasure:10];
    label.dyHeight +=[UIView getScaleWidthMeasureWithMeasure:6];
    label.dyY = (self.dyHeight - label.dyHeight)/2;
}

/**
 *  设置分号label的大小
 */
- (void)setUpFrameWithSepLabel:(UILabel *)label
{
    [label sizeToFit];
    label.dyWidth +=[UIView getScaleWidthMeasureWithMeasure:4];
    label.dyY = (self.dyHeight - label.dyHeight)/2;
}


/**
 *  设置每个Label的大小
 */
- (void)setLabelFont:(UIFont *)labelFont
{
    _labelFont = labelFont;
    
    self.hourFirstLabel.font = labelFont;
    self.hourSecondLabel.font = labelFont;
    
    self.minuteFirstLabel.font = labelFont;
    self.minuteSecondLabel.font = labelFont;
    
    self.secondsFirstLabel.font = labelFont;
    self.secondsSecondLabel.font = labelFont;
    
    [self layoutSubviews];
}

/**
 *  设置:label的大小
 */
- (void)setSepFont:(UIFont *)sepFont
{
    _sepFont = sepFont;
    
    self.firstSeparateLabel.font = sepFont;
    self.secondSeparateLabel.font = sepFont;
    
    [self layoutSubviews];
}



/**
 *  设置每个Label的背景色
 */
- (void)setNumberBackgroudColor:(UIColor *)numberBackgroudColor
{
    _numberBackgroudColor = numberBackgroudColor;
    
    self.hourFirstLabel.backgroundColor = numberBackgroudColor;
    self.hourSecondLabel.backgroundColor = numberBackgroudColor;
    
    self.minuteFirstLabel.backgroundColor = numberBackgroudColor;
    self.minuteSecondLabel.backgroundColor = numberBackgroudColor;
    
    self.secondsFirstLabel.backgroundColor = numberBackgroudColor;
    self.secondsSecondLabel.backgroundColor = numberBackgroudColor;
    
}

/**
 *  设置:的背景色
 */
- (void)setSepBackgroupColor:(UIColor *)sepBackgroupColor
{
    _sepBackgroupColor = sepBackgroupColor;
    
    self.firstSeparateLabel.backgroundColor = sepBackgroupColor;
    self.secondSeparateLabel.backgroundColor = sepBackgroupColor;
}

/**
 *  设置文字的颜色
 */
- (void)setLabelColor:(UIColor *)labelColor
{
    _labelColor = labelColor;
    
    self.hourFirstLabel.textColor = labelColor;
    self.hourSecondLabel.textColor = labelColor;
    
    self.minuteFirstLabel.textColor = labelColor;
    self.minuteSecondLabel.textColor = labelColor;
    
    self.secondsFirstLabel.textColor = labelColor;
    self.secondsSecondLabel.textColor = labelColor;
    
}

- (void)setSepColor:(UIColor *)sepColor
{
    _sepColor = sepColor;
    
    self.firstSeparateLabel.textColor = sepColor;
    self.secondSeparateLabel.textColor = sepColor;
}

/**
 *  传入秒数计算
 */
- (void)setCalculationTime:(NSInteger)calculationTime
{
    _calculationTime = calculationTime;
    
    if (calculationTime < 0) {
        NSLog(@"秒数出错");
        return;
    }
    
    self.currentTime = calculationTime;
    
    [self calculation];
    
    [self addTimer];
}

/**
 *  计算
 */
- (void)calculation
{
    //秒数
    //算出每个数
    NSInteger hour = self.currentTime/3600;
    NSInteger minute = (self.currentTime - hour * 3600)/60;
    NSInteger second = self.currentTime - hour * 3600 - minute * 60;
    
    NSInteger firHour = hour/10;
    NSInteger secHour = hour - firHour * 10;
    
    NSInteger firMinute = minute/10;
    NSInteger secMinute = minute - firMinute * 10;
    
    NSInteger firSeconds = second/10;
    NSInteger secSeconds = second - firSeconds * 10;
    
    self.hourFirstLabel.text = [NSString stringWithFormat:@"%zd",firHour];
    self.hourSecondLabel.text = [NSString stringWithFormat:@"%zd",secHour];
    
    self.minuteFirstLabel.text = [NSString stringWithFormat:@"%zd",firMinute];
    self.minuteSecondLabel.text = [NSString stringWithFormat:@"%zd",secMinute];
    
    self.secondsFirstLabel.text = [NSString stringWithFormat:@"%zd",firSeconds];
    self.secondsSecondLabel.text = [NSString stringWithFormat:@"%zd",secSeconds];
    
    if (secHour == 0 && firHour == 0 && firMinute == 0 && secMinute == 0 && firSeconds == 0 && secSeconds == 0) {
        [self invTimer];
        //做出特定的操作
        if ([self.delegate respondsToSelector:@selector(countdownViewTimerInv:)]) {
            [self.delegate countdownViewTimerInv:self];
        }
    }
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    if (self.timer) {
        [self.timer invalidate];
    }
    __weak DYCountDownView *weakSelf = self;
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(timerClick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时器数数
 */
- (void)timerClick
{
    self.currentTime -=1;
    [self calculation];
}

/**
 *  销毁定时器
 */
- (void)invTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)didEndterBackgroud
{
    self.isEndterToBackgroud = YES;
    //销毁定时器
    [self invTimer];
    //记住当前时间戳
    self.endterToBackgroudTime = [[NSDate date]timeIntervalSince1970];
}

- (void)didEndterForward
{
    if (self.isEndterToBackgroud) {
        self.isEndterToBackgroud = NO;
        //当前时间减去当时退到后台时间
        NSInteger currentTime = [[NSDate date]timeIntervalSince1970];
        NSInteger timeFix = currentTime - self.endterToBackgroudTime;
        self.currentTime = self.currentTime - timeFix;
        if (self.currentTime > 0) {
            //倒计时还是可以继续的
            [self calculation];
            [self addTimer];
        } else {
            self.hourFirstLabel.text = @"0";
            self.hourSecondLabel.text = @"0";
            self.minuteFirstLabel.text = @"0";
            self.minuteSecondLabel.text = @"0";
            self.secondsFirstLabel.text = @"0";
            self.secondsSecondLabel.text = @"0";
            //倒计时结束了
            if ([self.delegate respondsToSelector:@selector(countdownViewTimerInv:)]) {
                [self.delegate countdownViewTimerInv:self];
            }
        }
    }
}


@end
