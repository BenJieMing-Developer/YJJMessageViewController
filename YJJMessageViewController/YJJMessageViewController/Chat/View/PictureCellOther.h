//
//  PictureCellOther.h
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiPaoView.h"
@interface PictureCellOther : UITableViewCell
@property(nonatomic,strong)QiPaoView*backGroundImg;
@property(nonatomic,assign)CGFloat scale;
@property(nonatomic,assign)CGFloat photoWidth;
@property (strong, nonatomic)  UIImageView *headImage;
@property (strong, nonatomic) UILabel *sendDetail;
@property(strong,nonatomic) UIButton*picture;
@property(nonatomic,strong)UITapGestureRecognizer*tap;
@property(nonatomic,copy)nonReturnHasArguments tapBlock;
//@property (strong, nonatomic)  CircleProgress *circleProgress;
@end
