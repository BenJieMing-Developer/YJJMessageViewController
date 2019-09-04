//
//  reCordCell.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "VoiceOrVideoTalkCell.h"
#define Space 10
@implementation VoiceOrVideoTalkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStatus:(NSString *)status
{
    _status=status;
    [self.callButton setTitle:status forState:UIControlStateNormal];
    [self.callButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    CGSize size= [self.callButton sizeThatFits:CGSizeMake(MAXFLOAT, 37)];
    [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.updateExisting=YES;
        make.width.equalTo(@(size.width+Space*3));
    }];
}


-(void)call:(UIButton*)sender
{
    if (self.callBlock) {
        self.callBlock();
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    WEAKSELF
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
         self.contentView.backgroundColor=RGB(245, 245, 245, 1);
        [self.contentView addSubview:self.backGroundImg];
        [self.contentView addSubview:self.callButton];
        [self.contentView addSubview:self.headImage];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.lessThanOrEqualTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.headImage.mas_left).offset(-23);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
            make.height.equalTo(@39);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.callButton.mas_right).offset(16);
            make.top.equalTo(weakSelf.callButton.mas_top).offset(0);
            make.left.equalTo(weakSelf.callButton.mas_left).offset(-10);
            make.bottom.equalTo(weakSelf.callButton.mas_bottom).offset(0);
        }];
        
        
    }
    return self;
}


-(UIImageView*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[UIImageView alloc]init];
        [_backGroundImg setImage:[UIImage imageNamed:@"rightQiPao"]];
        
    }
    return _backGroundImg;
}
-(UIImageView*)headImage{
    if(!_headImage)    {
        _headImage=[[UIImageView alloc]init];
        _headImage.contentMode=UIViewContentModeScaleAspectFill;
        
    }
    return _headImage;
    
}
-(UIButton*)callButton
{
    if(!_callButton)
    {
        _callButton=[RecordCellButton buttonWithType:UIButtonTypeCustom];
        [_callButton setImage:[UIImage imageNamed:@"talk_ico_play_w3"] forState:UIControlStateNormal];
        [_callButton setTitle:@"" forState:UIControlStateNormal];
        [_callButton setTitleColor:[UIColor colorFromHexRGB:@"333333"] forState:UIControlStateNormal];
        _callButton.titleLabel.font=pingFangSCR(13);
    }
    return _callButton;
}


@end
