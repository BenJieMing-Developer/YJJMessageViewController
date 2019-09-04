//
//  EmojiButton.m
//  QuMa
//
//  Created by yjj on 2017/7/5.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "EmojiButton.h"

@implementation EmojiButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.bounds=CGRectMake(0, 0, 29, 29);
}

@end
