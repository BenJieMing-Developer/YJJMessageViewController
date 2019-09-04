//
//  SDWebImageReDrawImage.h
//  BasicProjectFramework
//
//  Created by yjj on 2018/4/14.
//  Copyright © 2018年 Yunjie. All rights reserved.
//

#import <SDWebImageManager.h>

typedef void(^drawResultBlock)(id);
typedef void(^progressBlock)(CGFloat);
@interface SDWebImageReDrawImage : NSObject
+(void)RedrawImageWithButton:(UIButton*)button ButtonState:(UIControlState)state URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block;
+(void)RedrawBackGroundImgWithButton:(UIButton*)button ButtonState:(UIControlState)state URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block;
+(void)RedrawImageWithImageView:(UIImageView*)imageView URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block;
@end
