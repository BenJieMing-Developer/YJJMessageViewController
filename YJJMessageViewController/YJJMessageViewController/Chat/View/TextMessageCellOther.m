//
//  TextMessageCellOther.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "TextMessageCellOther.h"
#define LabelMaxWidth   [UIScreen mainScreen].bounds.size.width-211
@implementation TextMessageCellOther

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UITapGestureRecognizer*)tap
{
    if (!_tap) {
        _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg)];
    }
    return _tap;
}

-(void)tapImg
{
    if (self.tapBlock) {
        self.tapBlock(nil);
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    WEAKSELF
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor=RGB(245, 245, 245, 1);
        [self.contentView addSubview:self.backGroundImg];
        [self.contentView addSubview:self.sendContent];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.sendDetail];
        [self.headImage addGestureRecognizer:self.tap];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.lessThanOrEqualTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [self.sendContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headImage.mas_right).offset(23);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(18);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-18);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.sendContent.mas_right).offset(9);
            make.top.equalTo(weakSelf.sendContent.mas_top).offset(-8);
            make.left.equalTo(weakSelf.sendContent.mas_left).offset(-16);
            make.bottom.equalTo(weakSelf.sendContent.mas_bottom).offset(7);
        }];
        [self.sendDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
        
    }
    return self;
}

-(UIImageView*)headImage
{
    if(!_headImage)
    {
        _headImage=[[UIImageView alloc]init];
        _headImage.contentMode=UIViewContentModeScaleAspectFill;
        _headImage.userInteractionEnabled=YES;
    }
    return _headImage;
}

-(UIImageView*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[UIImageView alloc]init];
        [_backGroundImg setImage:[UIImage imageNamed:@"leftQiPao"]];
        
    }
    return _backGroundImg;
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

-(UILabel*)sendDetail
{
    if(!_sendDetail)
    {
        _sendDetail=[[UILabel alloc]init];
        _sendDetail.textColor=CustomGrayColor;
        _sendDetail.font=pingFangSCR(13);
    }
    return _sendDetail;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
