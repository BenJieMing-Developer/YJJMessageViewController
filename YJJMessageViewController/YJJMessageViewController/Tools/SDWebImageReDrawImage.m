//
//  SDWebImageReDrawImage.m
//  BasicProjectFramework
//
//  Created by yjj on 2018/4/14.
//  Copyright © 2018年 Yunjie. All rights reserved.
//

#import "SDWebImageReDrawImage.h"
#import "Utils.h"
#import "UIImage+corner.h"

@interface SDWebImageReDrawImage()

@end

@implementation SDWebImageReDrawImage

+(void)RedrawImageWithButton:(UIButton*)button ButtonState:(UIControlState)state URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block
{
    [button setImage:holdImg forState:state];
    [[SDWebImageManager sharedManager]loadImageWithURL:url options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(expectedSize/(CGFloat)(expectedSize));
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        __block  UIImage*originalImage=image;
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                originalImage=[Utils drawImageWithImg:originalImage WithSize:size];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(originalImage);
                });
                
            });
        }
        else
        {
            block(holdImg);
        }
    }];
    
}

+(void)RedrawBackGroundImgWithButton:(UIButton*)button ButtonState:(UIControlState)state URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block
{
    [button setBackgroundImage:holdImg forState:state];
    [[SDWebImageManager sharedManager]loadImageWithURL:url options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(expectedSize/(CGFloat)(expectedSize));
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        __block  UIImage*originalImage=image;
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                originalImage=[Utils drawImageWithImg:originalImage WithSize:size];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(originalImage);
                });
                
            });
        }
        else
        {
            block(holdImg);
        }
    }];
    
}

+(void)RedrawImageWithImageView:(UIImageView*)imageView URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block
{
    [imageView setImage:holdImg];
    [[SDWebImageManager sharedManager]loadImageWithURL:url options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(expectedSize/(CGFloat)(expectedSize));
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        __block  UIImage*originalImage=image;
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                originalImage=[Utils drawImageWithImg:originalImage WithSize:size];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(originalImage);
                });
                
            });
        }
        else
        {
            block(holdImg);
        }
    }];
    
}
+(void)RedrawCornerImageWithImageView:(UIImageView*)imageView URL:(NSURL*)url placeHolderImg:(UIImage*)holdImg Size:(CGSize)size BorderWidth:(CGFloat)width backGroundColor:(UIColor*)color downloadProgress:(progressBlock)progress  WithDrawResult:(drawResultBlock)block
{
    [imageView setImage:holdImg];
    [[SDWebImageManager sharedManager]loadImageWithURL:url options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(expectedSize/(CGFloat)(expectedSize));
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        __block  UIImage*originalImage=image;
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                originalImage=[UIImage imageWithBorderWidth:2 Color:color image:originalImage size:size];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(originalImage);
                });
                
            });
        }
        else
        {
            block(holdImg);
        }
    }];
    
}
@end
