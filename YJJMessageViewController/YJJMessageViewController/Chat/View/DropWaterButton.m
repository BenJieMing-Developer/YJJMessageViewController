//
//  DropWaterButton.m
//  QuMa
//
//  Created by yjj on 2017/5/19.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "DropWaterButton.h"
#define conerRaiuds 8
#define bottomCircleRadius 4
@implementation DropWaterButton

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
    [self setNeedsDisplay];
}
-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextAddArc(ref, 12, 12,12,M_PI/3.0 ,M_PI/3.0*2.0,1);
    CGContextMoveToPoint(ref, 6 ,12+10.3923048);
    CGContextAddLineToPoint(ref,12, self.bounds.size.height);
    CGContextAddLineToPoint(ref, 18, 12+10.3923048);
    CAShapeLayer *arrowLayer = [CAShapeLayer layer];
    arrowLayer.path = CGContextCopyPath(ref);
    self.layer.mask = arrowLayer;

}
@end
