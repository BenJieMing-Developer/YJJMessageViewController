//
//  ReCordCellOther.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "RecordCellOther.h"
#define MaxRecordWidth 130.0
#define MaxRecordSecond 60.0
@implementation RecordCellOther

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
        sender.imageView.animationImages=@[[UIImage imageNamed:@"talk_ico_play_g1"],[UIImage imageNamed:@"talk_ico_play_g2"],[UIImage imageNamed:@"talk_ico_play_g3"]];
        sender.imageView.animationRepeatCount=ceil(_recordSecond);
        [sender.imageView startAnimating];
    }
    if (self.playRecordBlock) {
        self.playRecordBlock();
    }
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

-(UIImageView*)headImage{
    if(!_headImage)    {
        _headImage=[[UIImageView alloc]init];
        _headImage.contentMode=UIViewContentModeScaleAspectFill;
        _headImage.userInteractionEnabled=YES;
        
    }
    return _headImage;
    
}
-(UILabel*)sendDetail{
    if(!_sendDetail)    {
        _sendDetail=[[UILabel alloc]init];
        _sendDetail.textColor=CustomGrayColor;
        _sendDetail.font=pingFangSCR(13);
        
    }    return _sendDetail;
    
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
        _backGroundImg.image=[UIImage imageNamed:@"leftQiPao"];
        
    }
    return _backGroundImg;
}

-(UIButton*)playRecordButton
{
    if(!_playRecordButton)
    {
        _playRecordButton=[RecordCellOtherButton buttonWithType:UIButtonTypeCustom];
        [_playRecordButton setImage:[UIImage imageNamed:@"talk_ico_play_g3"] forState:UIControlStateNormal];
    }
    return _playRecordButton;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    WEAKSELF
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
         self.contentView.backgroundColor=RGB(245, 245, 245, 1);
        [self.contentView addSubview:self.backGroundImg];
        [self.contentView addSubview:self.playRecordButton];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.sendDetail];
        [self.contentView addSubview:self.recordLengthLabel];
        [self.contentView addSubview:self.errorImg];
        [self.headImage addGestureRecognizer:self.tap];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
        }];
        [self.playRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headImage.mas_right).offset(7);
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
        [self.sendDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
        [self.recordLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.backGroundImg.mas_right).offset(10);
            make.centerY.equalTo(weakSelf.backGroundImg.mas_centerY);
        }];
        [self.errorImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.recordLengthLabel.mas_right).offset(10);
            make.centerY.equalTo(weakSelf.recordLengthLabel.mas_centerY);
        }];
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
