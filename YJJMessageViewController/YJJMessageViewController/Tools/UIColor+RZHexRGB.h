//
//  UIColor+RZHexRGB.h
//  MaMiProject
//
//  Created by 李家瑞 on 16/3/15.
//  Copyright © 2016年 lijiarui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RZHexRGB)

/**
 *  获取颜色
 *
 *  @param inColorString RGB颜色值
 *
 *  @return UIcolor对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end
