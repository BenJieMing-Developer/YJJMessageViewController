//
//  TextMessageCellOther.h
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextMessageCellOther : UITableViewCell
@property (strong, nonatomic)  UIImageView *headImage;
@property (strong, nonatomic) UIImageView *backGroundImg;
@property (strong, nonatomic) UILabel *sendDetail;
@property (strong, nonatomic) UILabel *sendContent;
@property(nonatomic,strong)UITapGestureRecognizer*tap;
@property(nonatomic,copy)nonReturnHasArguments tapBlock;
@end
