//
//  NERewardADCell.m
//  testAnimate
//
//  Created by Mac on 2017/3/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NERewardADCell.h"

@implementation NERewardADCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36.0, 70.0)];
    }
    return self;
}

@end
