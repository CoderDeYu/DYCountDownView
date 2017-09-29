//
//  UIView+DyFrame.m
//  Camp
//
//  Created by 邓德宇 on 16/8/2.
//  Copyright © 2016年 meishakeji. All rights reserved.
//

#import "UIView+DYFrame.h"

@implementation UIView (DYFrame)

#pragma mark--------------set方法
- (void)setDyWidth:(CGFloat)dyWidth
{
    CGRect rect = self.frame;
    rect.size.width = dyWidth;
    self.frame = rect;
}

- (void)setDyHeight:(CGFloat)dyHeight
{
    CGRect rect = self.frame;
    rect.size.height = dyHeight;
    self.frame = rect;
}

- (void)setDyX:(CGFloat)dyX
{
    CGRect rect = self.frame;
    rect.origin.x = dyX;
    self.frame = rect;
}
- (void)setDyY:(CGFloat)dyY
{
    CGRect rect = self.frame;
    rect.origin.y = dyY;
    self.frame = rect;
}

#pragma mark--------------get方法

- (CGFloat)dyWidth
{
    return self.frame.size.width;
}

- (CGFloat)dyHeight
{
    return self.frame.size.height;
}

- (CGFloat)dyX
{
    return self.frame.origin.x;
}

- (CGFloat)dyY
{
    return self.frame.origin.y;
}


/**
 *  返回比例高度  getScaleMeasureWithMeasure
 */
+ (CGFloat)getScaleHeightMeasureWithMeasure:(CGFloat)measure
{
    //根据原型图iphone6返回尺寸
     float height = (measure) / 667;
    
    return (height * [UIScreen mainScreen].bounds.size.height);
}


/**
 *  返回比例宽度
 */
+ (CGFloat)getScaleWidthMeasureWithMeasure:(CGFloat)measure
{
    //根据原型图iphone6返回尺寸
    float width = (measure) / 375;
    
    return (width * [UIScreen mainScreen].bounds.size.width);
}



@end
