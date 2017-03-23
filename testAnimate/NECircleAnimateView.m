//
//  NECircleAnimateView.m
//  testAnimate
//
//  Created by Mac on 2017/3/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NECircleAnimateView.h"
#import "NECircleProgressView.h"
#import "UIView+Tool.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface NECircleAnimateView ()<CAAnimationDelegate>
{
    NECircleProgressView *_circleView;
    UIImageView *_animateImgV;
    UILabel * _coinTipsLabel;
    UILabel * _coinLabel;
    UILabel * _rewardCoinTipsLabel;
    UILabel * _rewardCoinLabel;
    CAKeyframeAnimation * _scaleAnimate;
    UIImageView * _coinTrackanimateImgV;
}



@end

@implementation NECircleAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        [self addSubview:bgImgV];
        bgImgV.image = [UIImage imageNamed:@"redBg"];
        
        UIImageView *redTrackImgV = [[UIImageView alloc] initWithFrame:CGRectMake(4.0, 4, 62.0, 62.0)];
        redTrackImgV.image = [UIImage imageNamed:@"redTrackBg"];
        [self addSubview:redTrackImgV];
        
        UILabel *coinTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20.0, 70.0, 17.0)];
        coinTipsLabel.textColor = [UIColor whiteColor];
        coinTipsLabel.font = [UIFont systemFontOfSize:12.0];
        coinTipsLabel.text = @"阅读奖励";
        coinTipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:coinTipsLabel];
        
        UILabel *coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(coinTipsLabel.frame), 70.0, 15.0)];
        coinLabel.font = [UIFont systemFontOfSize:12.0];
        coinLabel.textColor = [UIColor whiteColor];
        coinLabel.text = @"0000";
        coinLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:coinLabel];
        _coinLabel = coinLabel;
        
        //金币
        UIImageView *animateImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70.0, 70.0)];
        animateImgV.image = [UIImage imageNamed:@"coinBgIn"];
        [self addSubview:animateImgV];
        animateImgV.hidden = YES;
        _animateImgV = animateImgV;
        
        //小黄圈
        UIImageView *coinTrackanimateImgV = [[UIImageView alloc] initWithFrame:CGRectMake(4.0, 4.0, 62.0, 62.0)];
        coinTrackanimateImgV.image = [UIImage imageNamed:@"coinTrack"];
        [self addSubview:coinTrackanimateImgV];
        coinTrackanimateImgV.hidden = YES;
        _coinTrackanimateImgV = coinTrackanimateImgV;
    
        UILabel *rewardCoinTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 23.0, 70.0, 17.0)];
        rewardCoinTipsLabel.font = [UIFont systemFontOfSize:12.0];
        rewardCoinTipsLabel.textColor = UIColorFromRGB(0xeb7d11);
        rewardCoinTipsLabel.text = @"金币奖励";
        rewardCoinTipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:rewardCoinTipsLabel];
        rewardCoinTipsLabel.hidden = YES;
        _rewardCoinTipsLabel = rewardCoinTipsLabel;
        
        UILabel *rewardCoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(coinTipsLabel.frame), 70.0, 17.0)];
        rewardCoinLabel.font = [UIFont systemFontOfSize:14.0];
        rewardCoinLabel.textColor = UIColorFromRGB(0xeb7d11);
        rewardCoinLabel.text = @"+0";
        rewardCoinLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:rewardCoinLabel];
        rewardCoinLabel.hidden = YES;
        _rewardCoinLabel = rewardCoinLabel;
        rewardCoinLabel.y = 50.0;
        
        __weak typeof(self) weakSelf = self;
        NECircleProgressView * circle = [[NECircleProgressView alloc] initWithFrame:CGRectMake(0.0, 0.0, 70, 70.0)];
        circle.finished = ^{ //完成进度展示
            NSLog(@"startAnimate ----");
            //开始动画
            [weakSelf startAnimate];
            
        };
        [self addSubview:circle];
        _circleView = circle;
        circle.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


- (void)setProgress:(NSInteger)progress {
    _progress = progress;
    _circleView.progress = progress;
}

- (void)setGoldCoinNumber:(NSString *)goldCoinNumber {
    _goldCoinNumber = goldCoinNumber;
    _coinLabel.text = goldCoinNumber;
}

- (void)setRewardGoldCoinNumber:(NSString *)rewardGoldCoinNumber {
    _rewardGoldCoinNumber = rewardGoldCoinNumber;
    _rewardCoinLabel.text = rewardGoldCoinNumber;
}

- (void)startAnimate {
    _animateImgV.hidden = NO;
    _rewardCoinTipsLabel.hidden = NO;
    _rewardCoinLabel.hidden = NO;
    _coinTrackanimateImgV.hidden = NO;
    self.progress = 0;
    
    //放大
    [self scaleAnimate];
    _rewardCoinLabel.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        _rewardCoinLabel.alpha = 1.0;
        _rewardCoinLabel.y = 40.0;
    } completion:^(BOOL finished) {
        //            _rewardCoinLabel.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            _rewardCoinLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            NSLog(@"动画结束 ---");
            _rewardCoinLabel.y = 50.0;
            [self shirnkAnimate];
        }];
    }];
}

- (void)scaleAnimate {
    //放大
    CAKeyframeAnimation *scaleAnimate = [CAKeyframeAnimation animation];
    scaleAnimate.keyPath = @"bounds";
    NSValue *value1 = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    NSValue *value2 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 20.0, 20.0)];
    NSValue *value3 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 40.0, 40.0)];
    NSValue *value4 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 60.0, 60.0)];
    NSValue *value5 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 70.0, 70.0)];
    NSValue *value6 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 85.0, 85.0)];
    NSValue *value7 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 65.0, 65.0)];
    NSValue *value8 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 70.0, 70.0)];
    NSArray *boundsArr = @[value1, value2, value3, value4, value5,value6,value7,value8];
    scaleAnimate.values = boundsArr;
    scaleAnimate.duration = 0.5;
    scaleAnimate.removedOnCompletion = NO;
    scaleAnimate.fillMode = kCAFillModeForwards;
    scaleAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _animateImgV.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _animateImgV.clipsToBounds = YES;
    [_animateImgV.layer addAnimation:scaleAnimate forKey:nil];
    _rewardCoinTipsLabel.alpha = 0.0;
    _coinTrackanimateImgV.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        _rewardCoinTipsLabel.alpha = 1.0;
        _coinTrackanimateImgV.alpha = 1.0;
    }];
}

//缩小动画
- (void)shirnkAnimate {
    ////缩小
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animation];
    animate.delegate = self;
    animate.keyPath = @"bounds";
    NSValue *value1 = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    NSValue *value2 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 20.0, 20.0)];
    NSValue *value3 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 40.0, 40.0)];
    NSValue *value4 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 60.0, 60.0)];
    NSValue *value5 = [NSValue valueWithCGRect:CGRectMake(35.0, 35.0, 70.0, 70.0)];
    NSArray *boundsArr = @[value5, value4, value3, value2, value1];
    animate.values = boundsArr;
    animate.duration = 0.5;
    animate.removedOnCompletion = NO;
    animate.fillMode = kCAFillModeForwards;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _animateImgV.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [_animateImgV.layer addAnimation:animate forKey:nil];
    _rewardCoinTipsLabel.alpha = 1.0;
    _coinTrackanimateImgV.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        _rewardCoinTipsLabel.alpha = 0.0;
        _coinTrackanimateImgV.alpha = 0.0;
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop --- %@ --- %d",anim,flag);
    if (self.didFinished) {
        self.didFinished();
    }
}

@end
