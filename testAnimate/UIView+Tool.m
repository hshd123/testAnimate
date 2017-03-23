//
//  UIView+Tool.m
//  testFoundation
//
//  Created by Mac on 2017/2/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+Tool.h"
#import <objc/runtime.h>

static const void * cornerRadiusKey = "cornerRadiusKey";
static const void * borderWidthKey = "borderWidthKey";
static const void * borderColorKey = "borderColorKey";


@interface UIView()

@end

@implementation UIView (Tool)

@dynamic cornerRadius,borderColor,borderWidth;

- (void)setCornerRadius:(CGFloat)cornerRadius {
    NSNumber *number = [NSNumber numberWithFloat:cornerRadius];
    objc_setAssociatedObject(self, cornerRadiusKey, number, OBJC_ASSOCIATION_ASSIGN);
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

- (CGFloat)cornerRadius {
    return [objc_getAssociatedObject(self, cornerRadiusKey) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    NSNumber *number = [NSNumber numberWithFloat:borderWidth];
    objc_setAssociatedObject(self, borderWidthKey, number, OBJC_ASSOCIATION_ASSIGN);
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

- (CGFloat)borderWidth {
    return [objc_getAssociatedObject(self, borderWidthKey) floatValue];
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self, borderColorKey, borderColor, OBJC_ASSOCIATION_ASSIGN);
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, borderColorKey);

}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}


- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

@end
