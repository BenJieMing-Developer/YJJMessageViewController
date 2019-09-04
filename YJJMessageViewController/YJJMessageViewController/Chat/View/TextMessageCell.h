//
//  TextMessageCell.h
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextMessageCell : UITableViewCell
@property(strong,nonatomic)UIImageView*headImage;
@property(nonatomic,strong)UIImageView*backGroundImg;
@property (strong, nonatomic)  UILabel *sendContent;
@end
