//
//  NECircleProgressView.m
//  testAnimate
//
//  Created by Mac on 2017/3/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NECircleProgressView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface NECircleProgressView()
{
    CAShapeLayer * _progressLayer;
    CAGradientLayer *_gradientLayer;
    CALayer *_maskLayer;
}

@end

@implementation NECircleProgressView


- (void)drawRect:(CGRect)rect {
    
    CGPoint center = CGPointMake(35.0, 35.0);
    CGFloat radius = 28.0;
    CGFloat startA = - M_PI_2;
    CGFloat endA = M_PI_2 * 4  * (1.0 / 360.0 * (self.progress - 90));
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor = [UIColorFromRGB(0xffd35d) CGColor];
    _progressLayer.opacity = 1;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = 5.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    _progressLayer.path = [path CGPath];
    [self.layer addSublayer:_progressLayer];

    _maskLayer = [CALayer layer];
    //渐变色
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _gradientLayer.locations = @[@0.2,@1.0];
    
    _gradientLayer.colors = @[(id)[UIColorFromRGB(0xffff86) CGColor],(id)[UIColorFromRGB(0xffd35d) CGColor]];
    [_maskLayer addSublayer:_gradientLayer];
    
    [_maskLayer setMask:_progressLayer];
    [self.layer addSublayer:_maskLayer];
    
//    NSLog(@"drawRect -- %ld--- %f",self.progress,endA);
}

- (void)setProgress:(NSInteger)progress {
    if (progress > 360 || progress < 0) {
        NSLog(@"进度值不合法 .......");
    }
    _progress = progress;
    _progressLayer.opacity = 0.0;
    [self setNeedsDisplay];
    if (progress == 360) {
        progress = 0;
        if (self.finished) {
            self.finished();
        }
    }
}

@end
