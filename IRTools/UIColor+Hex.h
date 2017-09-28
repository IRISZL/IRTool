//
//  UIColor+Hex.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/15.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 （1）16进制转换为颜色值
 （2）颜色值转换为16进制
  (3) 16进制转换为颜色值（带有不同透明度）
 */

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 根据16进制生成颜色
 */
+ (UIColor *)UIColorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha;

/**
 根据16进制生成颜色（透明度为1）
 */
+ (UIColor *)UIColorFromHex:(NSUInteger)rgb;

/**
 根据颜色生成16进制
 返回值： #FFFFFF
 */
+ (NSString *)HexFromUIColor:(UIColor *)color;


@end
