//
//  ChoosePictureSourceView.h
//  quyue
//
//  Created by yjj on 2017/12/5.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePictureSourceView : UIView
@property(nonatomic,copy)nonReturnAndArguments choosePicture;
@property(nonatomic,copy)nonReturnAndArguments takePhoto;
@property(nonatomic,copy)NSString*firstTitle;
@property(nonatomic,copy)NSString*secondTitle;
-(void)showInView:(UIView*)superView;
-(void)dissmiss;
@end
