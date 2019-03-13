//
//  LDNormalHeaderView.m
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import "LDNormalHeaderView.h"

@implementation LDNormalHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor redColor];
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.text = @"这个头部可以使用UIView、tableView等";
    [tempLabel sizeToFit];
    tempLabel.center = self.center;
    [self addSubview:tempLabel];
}

@end
