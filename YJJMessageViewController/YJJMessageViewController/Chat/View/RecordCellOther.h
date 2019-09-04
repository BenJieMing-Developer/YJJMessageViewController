//
//  RecordCellOther.h
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCellOtherButton.h"
@interface RecordCellOther : UITableViewCell
@property (strong, nonatomic)  UIImageView *headImage;
@property(strong,nonatomic)UIImageView*errorImg;
@property (strong, nonatomic) UIImageView *backGroundImg;
@property (strong, nonatomic) UILabel *sendDetail;
@property (strong, nonatomic) RecordCellOtherButton *playRecordButton;
@property(strong,nonatomic)UILabel*recordLengthLabel;
@property(nonatomic,assign)CGFloat recordSecond;
@property(nonatomic,copy)nonReturnAndArguments playRecordBlock;
@property(nonatomic,strong)UITapGestureRecognizer*tap;
@property(nonatomic,copy)nonReturnHasArguments tapBlock;
@end
