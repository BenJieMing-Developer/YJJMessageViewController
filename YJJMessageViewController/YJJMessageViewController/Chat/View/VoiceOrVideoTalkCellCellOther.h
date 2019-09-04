//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCellOtherButton.h"
@interface VoiceOrVideoTalkCellCellOther: UITableViewCell
@property (strong, nonatomic)  UIImageView *headImage;
@property (strong, nonatomic) UIImageView *backGroundImg;
@property (strong, nonatomic) RecordCellOtherButton *callButton;
@property(nonatomic,strong)UILabel*sendDetail;
@property(copy,nonatomic)NSString*status;
@property(nonatomic,copy)nonReturnAndArguments callBlock;
@property(nonatomic,strong)UITapGestureRecognizer*tap;
@property(nonatomic,copy)nonReturnHasArguments tapBlock;
@end
