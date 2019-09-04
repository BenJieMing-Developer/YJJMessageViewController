//
//  RecordPopView.m
//  QuMa
//
//  Created by yjj on 2017/5/8.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "RecordPopView.h"

@implementation RecordPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    if (self=[super init]) {
        self=[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil]instantiateWithOwner:self options:nil ][0];
//        self.recordImageView.image=[UIImage imageNamed:@""];
    }
    return self;
}


-(void)showInCenter:(UIView*)View

{
    self.recordImageView.animationImages=@[[UIImage imageNamed:@"microphone1"],[UIImage imageNamed:@"microphone2"],[UIImage imageNamed:@"microphone3"],[UIImage imageNamed:@"microphone4"],[UIImage imageNamed:@"microphone5"]];
    self.recordImageView.animationDuration=1.5;
    self.recordImageView.animationRepeatCount=0;
    [self.recordImageView startAnimating];
    self.frame=View.bounds;
    self.tishiLabel.backgroundColor=[UIColor clearColor];
    self.tishiLabel.text=@"手指上划,取消发送";
    [View addSubview:self];
}
-(void)dissmiss
{
    [self.recordImageView stopAnimating];
    self.tishiLabel.backgroundColor=[UIColor clearColor];
    self.tishiLabel.text=@"手指上划,取消发送";
    [self removeFromSuperview];
}

@end
