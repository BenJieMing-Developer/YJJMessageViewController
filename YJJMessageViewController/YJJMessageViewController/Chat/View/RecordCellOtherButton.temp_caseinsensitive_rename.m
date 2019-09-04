//
//  RecordCellOtherButton.m
//  quyue
//
//  Created by yjj on 2017/12/26.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "RecordCellOtherButton.h"
#define rightSpace 10
@implementation RecordCellOtherButton

-(void)setHighlighted:(BOOL)highlighted
{
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect1=self.imageView.frame;
    CGRect rect2=self.titleLabel.frame;
    self.imageView.frame=CGRectMake(self.frame.size.width-rect1.size.width-rightSpace,rect1.origin.y,rect1.size.width, rect1.size.height);
 self.titleLabel.frame=CGRectMake(self.frame.size.width-rect1.size.width-rightSpace-rightSpace-rect2.size.width,rect2.origin.y,rect2.size.width, rect2.size.height);
    
}


@end
