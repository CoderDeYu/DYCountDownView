//
//  UIColor+MSHex.h
//  Camp
//
//  Created by 邓德宇 on 16/8/3.
//  Copyright © 2016年 meishakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DYHex)

/**
 *   默认alpha位1
 */
+ (UIColor *)colorWithHexString:(NSString *)color;


/**
 *  从十六进制字符串获取颜色，
 *  color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
