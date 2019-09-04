//
//  ReCordCell.h
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCellButton.h"
@interface VoiceOrVideoTalkCell : UITableViewCell
@property (strong, nonatomic) UIImageView *backGroundImg;
@property (strong, nonatomic) RecordCellButton *callButton;
@property(nonatomic,copy)NSString* status;
@property(nonatomic,strong)UIImageView*headImage;
@property(nonatomic,copy)nonReturnAndArguments callBlock;
@end
