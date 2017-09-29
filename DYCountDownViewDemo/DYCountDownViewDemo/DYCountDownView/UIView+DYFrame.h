//
//  UIView+MSFrame.h
//  Camp
//
//  Created by 邓德宇 on 16/8/2.
//  Copyright © 2016年 meishakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DYFrame)

@property CGFloat dyHeight;
@property CGFloat dyWidth;
@property CGFloat dyX;
@property CGFloat dyY;

/**
 *  返回比例高度
 */
+ (CGFloat)getScaleHeightMeasureWithMeasure:(CGFloat)measure;

/**
 *  返回比例宽度
 */
+ (CGFloat)getScaleWidthMeasureWithMeasure:(CGFloat)measure;
@end
