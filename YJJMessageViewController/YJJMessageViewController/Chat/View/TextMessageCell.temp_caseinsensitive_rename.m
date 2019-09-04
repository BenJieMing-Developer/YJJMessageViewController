//
//  TextMessageCell.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "TextMessageCell.h"
#define LabelMaxWidth   [UIScreen mainScreen].bounds.size.width-211
@implementation TextMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    WEAKSELF
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
         self.contentView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.backGroundImg];
        [self.contentView addSubview:self.sendContent];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.lessThanOrEqualTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [self.sendContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.headImage.mas_left).offset(-23);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(18);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-18);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.sendContent.mas_right).offset(16);
            make.top.equalTo(weakSelf.sendContent.mas_top).offset(-8);
            make.left.equalTo(weakSelf.sendContent.mas_left).offset(-10);
            make.bottom.equalTo(weakSelf.sendContent.mas_bottom).offset(8);
        }];

        
    }
    return self;
}

-(UIImageView*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[UIImageView alloc]init];
        _backGroundImg.opaque=YES;
        [_backGroundImg setImage:[UIImage imageNamed:@"rightQiPao"]];
    }
    return _backGroundImg;
}
-(UIImageView*)headImage
{
    if(!_headImage)
    {
        _headImage=[[UIImageView alloc]init];
        _headImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _headImage;
}
-(UILabel*)sendContent
{
    if(!_sendContent)
    {
        _sendContent=[[UILabel alloc]init];
        _sendContent.font=pingFangSCR(13);
        _sendContent.numberOfLines=0;
        _sendContent.textAlignment=NSTextAlignmentLeft;
        _sendContent.textColor=[UIColor colorFromHexRGB:@"333333"];
        _sendContent.preferredMaxLayoutWidth=LabelMaxWidth;
    }
    return _sendContent;
    
}

@end
