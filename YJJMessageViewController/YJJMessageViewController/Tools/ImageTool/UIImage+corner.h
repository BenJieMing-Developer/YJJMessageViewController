//
//  UIImage+corner.h
//  贝塞尔曲线画圆
//
//  Created by admin on 16/10/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (corner)
+(UIImage*)imageWithBorderWidth:(CGFloat)width Color:(UIColor*)color image:(UIImage*)image size:(CGSize)size;

@end
