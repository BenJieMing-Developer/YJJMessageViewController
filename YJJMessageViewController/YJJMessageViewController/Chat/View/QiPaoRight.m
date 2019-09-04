//
//  QiPaoRight.m
//  QuMa
//
//  Created by yjj on 2017/6/26.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "QiPaoRight.h"
#define conerRaiuds 4
#define rightDistance 7
#define rightHeight  14
#define topDistance 21

@implementation QiPaoRight

- (void)drawRect:(CGRect)rect {
       CGContextRef ref=UIGraphicsGetCurrentContext();
       CGContextMoveToPoint(ref,self.bounds.size.width-rightDistance, conerRaiuds);
    CGContextAddLineToPoint(ref,self.bounds.size.width-rightDistance, topDistance-rightHeight/2.0);
    CGContextAddLineToPoint(ref, self.bounds.size.width, topDistance);
    CGContextAddLineToPoint(ref, self.bounds.size.width-rightDistance, topDistance+rightHeight/2.0);
    CGContextAddLineToPoint(ref, self.bounds.size.width-rightDistance, self.bounds.size.height-conerRaiuds);
    CGContextAddArcToPoint(ref, self.bounds.size.width-rightDistance, self.bounds.size.height, self.bounds.size.width-rightDistance-conerRaiuds, self.bounds.size.height,conerRaiuds);
    CGContextAddLineToPoint(ref,conerRaiuds, self.bounds.size.height);
    CGContextAddArcToPoint(ref,0, self.bounds.size.height,0, self.bounds.size.height-conerRaiuds, conerRaiuds);
    CGContextAddLineToPoint(ref, 0, conerRaiuds);
    CGContextAddArcToPoint(ref, 0, 0, conerRaiuds, 0, conerRaiuds);
    CGContextAddLineToPoint(ref,self.bounds.size.width-conerRaiuds-rightDistance, 0);
    CGContextAddArcToPoint(ref, self.bounds.size.width-rightDistance, 0, self.bounds.size.width-rightDistance, conerRaiuds, conerRaiuds);
    CGContextSetLineWidth(ref, 1);
    if (!self.StrokeColor) {
        CGContextSetRGBStrokeColor(ref, 0.609375 , 0.609375, 0.609375, 1);

    }
    else
    {
       const CGFloat *Color= CGColorGetComponents(self.StrokeColor.CGColor);
        CGContextSetStrokeColor(ref, Color);
    }
    CAShapeLayer*layer=[CAShapeLayer layer];
    layer.path=CGContextCopyPath(ref);
    self.layer.mask=layer;
    CGContextDrawPath(ref, kCGPathStroke);
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.clipsToBounds=YES;
    [self setNeedsDisplay];
}
-(void)setStrokeColor:(UIColor *)StrokeColor
{
    _StrokeColor=StrokeColor;
    [self setNeedsDisplay];
}
@end
