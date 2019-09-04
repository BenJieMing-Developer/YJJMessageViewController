//
//  TopImgBottomTextButton.m
//  quyue
//
//  Created by yjj on 2017/12/5.
//  Copyright © 2017年 Yunjie. All rights reserved.
//

#import "TopImgBottomTextButton.h"

@implementation TopImgBottomTextButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect1=self.imageView.frame;
    CGRect rect2=self.titleLabel.frame;
    if (rect1.origin.x<rect2.origin.x) {
        self.imageView.frame=CGRectMake((self.bounds.size.width-rect1.size.width)/2,rect1.origin.y-5,rect1.size.width,rect1.size.height);
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.frame=CGRectMake(0,CGRectGetMaxY(self.imageView.frame)+5,self.bounds.size.width,rect2.size.height);
    }
    
    
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
