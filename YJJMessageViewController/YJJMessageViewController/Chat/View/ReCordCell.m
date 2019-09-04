//
//  reCordCell.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "ReCordCell.h"
#define MaxRecordWidth 130.0
#define MaxRecordSecond 60.0
@implementation ReCordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRecordSecond:(CGFloat)recordSecond
{
    _recordSecond=recordSecond;
    if (_recordSecond>MaxRecordSecond) {
        _recordSecond=MaxRecordSecond;
    }
    [self.playRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.updateExisting=YES;
        make.width.equalTo(@(60+ceil(_recordSecond-1)/MaxRecordSecond*MaxRecordWidth));
    }];
    self.recordLengthLabel.text=[NSString stringWithFormat:@"%.0lf\"",_recordSecond];
    [self.playRecordButton addTarget:self action:@selector(playRecord:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)playRecord:(UIButton*)sender
{
    if (!sender.imageView.animating) {
        sender.imageView.animationDuration=1;
        sender.imageView.animationImages=@[[UIImage imageNamed:@"talk_ico_play_w1"],[UIImage imageNamed:@"talk_ico_play_w2"],[UIImage imageNamed:@"talk_ico_play_w3"]];
        sender.imageView.animationRepeatCount=ceil(_recordSecond);
        [sender.imageView startAnimating];
    }
    if (self.playRecordBlock) {
        self.playRecordBlock();
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    WEAKSELF
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
         self.contentView.backgroundColor=RGB(245, 245, 245, 1);
        [self.contentView addSubview:self.backGroundImg];
        [self.contentView addSubview:self.playRecordButton];
        [self.contentView addSubview:self.recordLengthLabel];
        [self.contentView addSubview:self.errorImg];
        [self.contentView addSubview:self.headImage];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.lessThanOrEqualTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [self.playRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.headImage.mas_left).offset(-7);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
            make.height.equalTo(@39);
            make.width.equalTo(@86);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.playRecordButton.mas_right).offset(0);
            make.top.equalTo(weakSelf.playRecordButton.mas_top).offset(0);
            make.left.equalTo(weakSelf.playRecordButton.mas_left).offset(0);
            make.bottom.equalTo(weakSelf.playRecordButton.mas_bottom).offset(0);
        }];
        [self.recordLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.backGroundImg.mas_left).offset(-10);
            make.centerY.equalTo(weakSelf.backGroundImg.mas_centerY);
        }];
        [self.errorImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.recordLengthLabel.mas_left).offset(-10);
            make.centerY.equalTo(weakSelf.recordLengthLabel.mas_centerY);
        }];
        
        
    }
    return self;
}

-(UILabel*)recordLengthLabel
{
    if (!_recordLengthLabel) {
        _recordLengthLabel=[[UILabel alloc]init];
        _recordLengthLabel.font=pingFangSCR(12);
        _recordLengthLabel.textColor=CustomGrayColor;
    }
    return _recordLengthLabel;
}

-(UIImageView*)errorImg
{
    if (!_errorImg) {
        _errorImg=[[UIImageView alloc]init];
        _errorImg.image=[UIImage imageNamed:@"talk_ico_send_failed"];
        _errorImg.hidden=YES;
    }
    return _errorImg;
}

-(UIImageView*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[UIImageView alloc]init];
        _backGroundImg.image=[UIImage imageNamed:@"rightQiPao"];
        
    }
    return _backGroundImg;
}
-(UIImageView*)headImage
{
    if (!_headImage) {
        _headImage=[[UIImageView alloc]init];
        _headImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _headImage;
}
-(UIButton*)playRecordButton
{
    if(!_playRecordButton)
    {
        _playRecordButton=[RecordCellButton buttonWithType:UIButtonTypeCustom];
        [_playRecordButton setImage:[UIImage imageNamed:@"talk_ico_play_w3"] forState:UIControlStateNormal];
        
    }
    return _playRecordButton;
}


@end
