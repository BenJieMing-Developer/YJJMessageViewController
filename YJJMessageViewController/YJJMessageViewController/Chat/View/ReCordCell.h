//
//  ReCordCell.h
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCellButton.h"

@interface ReCordCell : UITableViewCell
@property(strong,nonatomic)UIImageView*errorImg;
@property (strong, nonatomic) UIImageView *backGroundImg;
@property (strong, nonatomic) RecordCellButton *playRecordButton;
@property(strong,nonatomic)UILabel*recordLengthLabel;
@property(nonatomic,assign)CGFloat recordSecond;
@property(nonatomic,strong)UIImageView*headImage;
@property(nonatomic,copy)nonReturnAndArguments playRecordBlock;
@end
