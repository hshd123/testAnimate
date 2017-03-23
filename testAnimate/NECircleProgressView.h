//
//  NECircleProgressView.h
//  testAnimate
//
//  Created by Mac on 2017/3/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinishBlock)();
@interface NECircleProgressView : UIView

@property (nonatomic , copy) FinishBlock finished;
@property (nonatomic , assign) NSInteger progress;

@end
