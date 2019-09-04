//
//  ChoosePictureSourceView.m
//  quyue
//
//  Created by yjj on 2017/12/5.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "ChoosePictureSourceView.h"

@interface ChoosePictureSourceView()
@property(nonatomic,strong)UIView*contentView;
@property(nonatomic,strong)UIButton*firstButton;
@property(nonatomic,strong)UIButton*secondButton;

@end

@implementation ChoosePictureSourceView

-(void)showInView:(UIView *)superView
{
    WEAKSELF
    self.frame=superView.bounds;
    [superView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
       weakSelf.contentView.frame=CGRectMake(0,SCREENH_HEIGHT-152,SCREEN_WIDTH,152);
    }];
}
-(void)dissmiss
{
    
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundColor=[UIColor clearColor];
        weakSelf.contentView.frame=CGRectMake(0,SCREENH_HEIGHT,SCREEN_WIDTH,152);
    }completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
   
}
-(instancetype)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor clearColor];
        self.contentView=[[UIView alloc]init];
        self.contentView.backgroundColor=RGB(228, 227, 234, 1);
        self.contentView.frame=CGRectMake(0,SCREENH_HEIGHT,SCREEN_WIDTH,152);
        [self addSubview:self.contentView];
        UIButton*choosePhoto=[UIButton buttonWithType:UIButtonTypeCustom];
        choosePhoto.frame=CGRectMake(0, 0,self.contentView.frame.size.width,48);
        choosePhoto.backgroundColor=[UIColor whiteColor];
        [choosePhoto setTitle:@"选照片" forState:UIControlStateNormal];
        [choosePhoto setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [choosePhoto addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:choosePhoto];
        self.firstButton=choosePhoto;
        UIView*lineView=[[UIView alloc]init];
        lineView.backgroundColor=RGB(247, 247, 247, 1);
        lineView.frame=CGRectMake(0,CGRectGetMaxY(choosePhoto.frame),self.contentView.frame.size.width,0.5);
        [self.contentView addSubview:lineView];
        UIButton*takePhoto=[UIButton buttonWithType:UIButtonTypeCustom];
        takePhoto.frame=CGRectMake(0, CGRectGetMaxY(lineView.frame),self.contentView.frame.size.width,48);
        takePhoto.backgroundColor=[UIColor whiteColor];
        [takePhoto setTitle:@"拍照片" forState:UIControlStateNormal];
        [takePhoto setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [takePhoto addTarget:self action:@selector(takePhotoClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:takePhoto];
        self.secondButton=takePhoto;
        UIButton*cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame=CGRectMake(0, CGRectGetMaxY(takePhoto.frame)+4 ,self.contentView.frame.size.width,self.contentView.frame.size.height- CGRectGetMaxY(takePhoto.frame)-4);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
          [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.backgroundColor=[UIColor whiteColor];
        [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancelButton];
        
        
    }
    return self;
}
-(void)choosePhoto
{
    if (self.choosePicture) {
        self.choosePicture();
    }
}
-(void)takePhotoClick
{
    if (self.takePhoto) {
        self.takePhoto();
    }
}
-(void)setFirstTitle:(NSString *)firstTitle
{
    _firstTitle=firstTitle;
    [self.firstButton setTitle:_firstTitle forState:UIControlStateNormal];
    
}
-(void)setSecondTitle:(NSString *)secondTitle
{
    _secondTitle=secondTitle;
    [self.secondButton setTitle:_secondTitle forState:UIControlStateNormal];
    
}
-(void)cancel
{
    [self dissmiss];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    if (point.y<CGRectGetMaxY(self.contentView.frame)) {
        [self dissmiss];
    }
}


@end
