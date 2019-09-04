//
//  ReCordCellButton.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "RecordCellButton.h"
#define leftSpace 10
@implementation RecordCellButton
-(void)setHighlighted:(BOOL)highlighted
{
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect1=self.imageView.frame;
    CGRect rect2=self.titleLabel.frame;
    self.imageView.frame=CGRectMake(leftSpace,rect1.origin.y,rect1.size.width, rect1.size.height);
    self.titleLabel.frame=CGRectMake(leftSpace+rect1.size.width+leftSpace,rect2.origin.y, rect2.size.width, rect2.size.height);
    
}


@end
