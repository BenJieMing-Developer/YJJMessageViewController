//
//  UIImage+corner.m
//  贝塞尔曲线画圆
//
//  Created by admin on 16/10/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIImage+corner.h"

@implementation UIImage (corner)
+(UIImage*)imageWithBorderWidth:(CGFloat)width Color:(UIColor *)color image:(UIImage *)image size:(CGSize)size
{
    UIImage*myImage=[image imageWithSize:size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(myImage.size.width+width*2, myImage.size.width+width*2), NO, 0);
    UIBezierPath*path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0 , 0, myImage.size.width+width*2, myImage.size.width+width*2)];
     [path addClip];
    if (width!=0) {
        [color set];
        [path fill];
       UIBezierPath*path1=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(width, width, myImage.size.width, myImage.size.width)];
        [path1 addClip];
       
        

    }
    
    [myImage drawAtPoint:CGPointMake(width, width)];
    myImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
    
    
}
-(UIImage*)imageWithSize:(CGSize)size {
   
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width ,size.height)];
    UIImage*myimage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myimage;
    
}



@end
