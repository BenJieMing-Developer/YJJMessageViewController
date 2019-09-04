//
//  PictureCell.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "PictureCell.h"
#define MaxPhtoWidth  120
#define MaxPhotoHeight  200
@implementation PictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.width.height.equalTo(@38);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.lessThanOrEqualTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [self.backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.picture.mas_right).offset(0);
            make.top.equalTo(weakSelf.picture.mas_top).offset(1);
            make.left.equalTo(weakSelf.picture.mas_left).offset(1);
            make.bottom.equalTo(weakSelf.picture.mas_bottom).offset(-1);
        }];
        
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.headImage.mas_left).offset(-7);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-18);
            make.width.height.equalTo(@40);
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
    }
    return _headImage;
}

-(QiPaoRight*)backGroundImg
{
    if(!_backGroundImg)
    {
        _backGroundImg=[[QiPaoRight alloc]init];
        _backGroundImg.StrokeColor=RGB(245, 245, 245, 1);
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
