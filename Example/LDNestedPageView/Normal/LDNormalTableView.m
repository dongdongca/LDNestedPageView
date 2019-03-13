//
//  LDNormalTableView.m
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import "LDNormalTableView.h"

@interface LDNormalTableView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@end

@implementation LDNormalTableView

//当前view是否支持刷新
@synthesize isSupportTheRefresh = _isSupportTheRefresh;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _isSupportTheRefresh = NO;
        self.backgroundColor = [UIColor yellowColor];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NormalTableViewcell"];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewcell" forIndexPath:indexPath];
    cell.textLabel.text = @"NormalTableViewcell";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

#pragma mark - IQHPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self;
}


@end
