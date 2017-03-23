//
//  NERewardView.m
//  testAnimate
//
//  Created by Mac on 2017/3/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NERewardView.h"
#import "NECircleAnimateView.h"
#import "NERewardADCell.h"

@interface NERewardView ()<UITableViewDataSource,UITableViewDelegate>
{
    NECircleAnimateView *_animateView;
    UITableView * _tableView;
}

@property (nonatomic , strong) NSMutableArray * dataSource;

@end

@implementation NERewardView
#pragma mark -- 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 70.0, 70.0) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _tableView = tableView;
        
        NECircleAnimateView *animateView = [[NECircleAnimateView alloc] initWithFrame:CGRectMake(0, 0, 70.0,70.0)];
        animateView.layer.cornerRadius = 35.0;
        animateView.clipsToBounds = YES;
        animateView.layer.masksToBounds = YES;
        [self addSubview:animateView];
        __weak typeof(self)weakSelf = self;
        animateView.didFinished = ^{
            __strong typeof(self)strongSelf = weakSelf;
            if (strongSelf.animateDidFinished) {
                strongSelf.animateDidFinished();
            }
        };
        _animateView = animateView;
    
    }
    
    return self;
}

#pragma mark -- 属性相关方法

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setProgress:(NSInteger)progress {
    _progress = progress;
    _animateView.progress = progress;
}

- (void)setGoldCoinNumber:(NSString *)goldCoinNumber {
    _goldCoinNumber = goldCoinNumber;
    _animateView.goldCoinNumber = goldCoinNumber;
}

- (void)setRewardGoldCoinNumber:(NSString *)rewardGoldCoinNumber {
    _rewardGoldCoinNumber = rewardGoldCoinNumber;
    _animateView.rewardGoldCoinNumber = rewardGoldCoinNumber;
}

#pragma mark -- tableView 相关方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifyer = @"NERewardADCell";
    NERewardADCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifyer];
    if (cell == nil) {
        cell = [[NERewardADCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifyer];
    }
    cell.dataModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}





@end
