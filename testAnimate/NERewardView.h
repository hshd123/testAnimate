//
//  NERewardView.h
//  testAnimate
//
//  Created by Mac on 2017/3/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CircleAnimateFinishedBlock)();

@interface NERewardView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) NSInteger progress;
//四位奖励数据
@property (nonatomic , copy) NSString * goldCoinNumber;

//奖励多少金币  +10
@property (nonatomic , copy) NSString * rewardGoldCoinNumber;

@property (nonatomic , copy) CircleAnimateFinishedBlock animateDidFinished;



@end
