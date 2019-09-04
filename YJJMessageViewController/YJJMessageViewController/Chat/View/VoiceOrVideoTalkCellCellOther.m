//
//  RecordCellOther.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "VoiceOrVideoTalkCellCellOther.h"
#define Space 10
@implementation VoiceOrVideoTalkCellCellOther

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setStatus:(NSString *)status
{
    _status=status;
    [self.callButton setTitle:status forState:UIControlStateNormal];
    [self.callButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
   CGSize size= [self.callButton sizeThatFits:CGSizeMake(MAXFLOAT, 37)];
    [self.callButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.updateExisting=YES;
       make.width.equalTo(@(size.width+Space*3));
    }];
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


-(void)call:(UIButton*)sender
{
    if (self.callBlock) {
        self.callBlock();
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
-(UIImageView*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[UIImageView alloc]init];
        [_backGroundImg setImage:[UIImage imageNamed:@"leftQiPao"]];
        
    }
    return _backGroundImg;
}

-(UIButton*)callButton
{
    if(!_callButton)
    {
        _callButton=[RecordCellOtherButton buttonWithType:UIButtonTypeCustom];
        [_callButton setImage:[UIImage imageNamed:@"talk_ico_play_g3"] forState:UIControlStateNormal];
        [_callButton setTitle:@"" forState:UIControlStateNormal];
        [_callButton setTitleColor:[UIColor colorFromHexRGB:@"333333"] forState:UIControlStateNormal];
        _callButton.titleLabel.font=pingFangSCR(13);
       
    }
    return _callButton;
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
        [self.contentView addSubview:self.sendDetail];
        [self.headImage addGestureRecognizer:self.tap];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.width.height.equalTo(@38);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.lessThanOrEqualTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headImage.mas_right).offset(23);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
            make.height.equalTo(@39);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.callButton.mas_right).offset(10);
            make.top.equalTo(weakSelf.callButton.mas_top).offset(0);
            make.left.equalTo(weakSelf.callButton.mas_left).offset(-16);
            make.bottom.equalTo(weakSelf.callButton.mas_bottom).offset(0);
        }];
        [self.sendDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
