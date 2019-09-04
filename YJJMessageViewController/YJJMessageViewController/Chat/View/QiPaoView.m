//
//  QiPaoView.m
//  QuMa
//
//  Created by yjj on 2017/6/23.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "QiPaoView.h"
#define conerRaiuds 4
#define leftDistance 6
#define leftHeight  12
#define topDistance 21
@implementation QiPaoView
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    self.clipsToBounds=YES;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef ref=UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ref, leftDistance, conerRaiuds);
    CGContextAddLineToPoint(ref, leftDistance, topDistance-leftHeight/2.00);
    CGContextAddLineToPoint(ref, 0, topDistance);
    CGContextAddLineToPoint(ref, leftDistance ,topDistance+leftHeight/2.00);
    CGContextAddLineToPoint(ref, leftDistance, self.bounds.size.height-conerRaiuds);
    CGContextAddArcToPoint(ref, leftDistance, self.bounds.size.height, leftDistance+conerRaiuds, self.bounds.size.height, conerRaiuds);
    CGContextAddArcToPoint(ref, self.bounds.size.width, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height-conerRaiuds,conerRaiuds);
    CGContextAddLineToPoint(ref,self.bounds.size.width, conerRaiuds);
    CGContextAddArcToPoint(ref, self.bounds.size.width, 0, self.bounds.size.width-conerRaiuds, 0, conerRaiuds);
    
    CGContextAddLineToPoint(ref, conerRaiuds+leftDistance, 0);
    
    CGContextAddArcToPoint(ref, leftDistance, 0, leftDistance, conerRaiuds, conerRaiuds);
    if (self.strokeColor) {
     const CGFloat *components = CGColorGetComponents(self.strokeColor.CGColor);
    CGContextSetRGBStrokeColor(ref, components[0] , components[1] ,components[2], 1);
    }
    else
    {
       CGContextSetRGBStrokeColor(ref, 0.609375 , 0.609375, 0.609375, 1);
    }
     CGContextSetLineWidth(ref,1);
    CAShapeLayer *arrowLayer = [CAShapeLayer layer];
    arrowLayer.path = CGContextCopyPath(ref);
    self.layer.mask = arrowLayer;
    CGContextDrawPath(ref, kCGPathStroke);


  
  
}
-(void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor=strokeColor;
    [self setNeedsDisplay];
}


@end
