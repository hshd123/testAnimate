//
//  UIView+Tool.h
//  testFoundation
//
//  Created by Mac on 2017/2/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tool)


@property (nonatomic , assign) CGFloat cornerRadius;
@property (nonatomic , assign) CGFloat borderWidth;
@property (nonatomic , copy) UIColor * borderColor;



@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end
