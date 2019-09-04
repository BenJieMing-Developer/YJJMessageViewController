//
//  PictureCellOther.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "PictureCellOther.h"
#define MaxPhtoWidth  120
#define MaxPhotoHeight  200
@implementation PictureCellOther

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
        _sendDetail.font=pingFangSCR(14);
        
    }    return _sendDetail;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    WEAKSELF
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
         self.contentView.backgroundColor=RGB(245, 245, 245, 1);
        [self.contentView addSubview:self.backGroundImg];
        [self.backGroundImg addSubview:self.picture];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.sendDetail];
        [self.headImage addGestureRecognizer:self.tap];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
        }];
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headImage.mas_right).offset(7);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-18);
            make.height.width.equalTo(@40);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.picture.mas_right).offset(-1);
            make.top.equalTo(weakSelf.picture.mas_top).offset(1);
            make.left.equalTo(weakSelf.picture.mas_left).offset(0);
            make.bottom.equalTo(weakSelf.picture.mas_bottom).offset(-1);
        }];
        [self.sendDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
      
        
    }
    return self;
}

-(QiPaoView*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[QiPaoView alloc]init];
        _backGroundImg.strokeColor=RGB(245, 245, 245, 1);
        _backGroundImg.backgroundColor=RGB(245, 245, 245, 1);
        
    }
    return _backGroundImg;
}
-(UIButton*)picture
{
    if(!_picture)
    {
        _picture=[UIButton buttonWithType:UIButtonTypeCustom];
        _picture.imageView.contentMode=UIViewContentModeScaleAspectFill;
        _picture.imageView.clipsToBounds=YES;
    }
    return _picture;
    
}

-(void)setPhotoWidth:(CGFloat)photoWidth
{
    _photoWidth=photoWidth;
    if(_photoWidth>MaxPhtoWidth)
    {
        _photoWidth=MaxPhtoWidth;
    }
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.updateExisting=YES;
        make.width.equalTo(@(_photoWidth));
    }];
}

-(void)setScale:(CGFloat)scale
{
    _scale=scale;
    if(_scale*_photoWidth>MaxPhotoHeight)
    {
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.updateExisting=YES;
            make.height.equalTo(@(MaxPhotoHeight));
        }];
    }
    else
    {
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.updateExisting=YES;
            make.height.equalTo(@(_scale*_photoWidth));
        }];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
