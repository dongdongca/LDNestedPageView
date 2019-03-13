//
//  LDNestedView.m
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import "LDNestedView.h"

@interface LDNestedView () <UITableViewDataSource, UITableViewDelegate, LDNestedListContainerViewDelegate, LDNestedMainTableViewGestureDelegate>

/// mainTableView
@property (nonatomic, strong) LDNestedMainTableView *mainTableView;
/// 当前容器view
@property (nonatomic, strong) LDNestedListContainerView *listContainerView;
/// 当前滚动的listView
@property (nonatomic, strong) UIScrollView *currentScrollingListView;
/// 当前显示的view
@property (nonatomic, strong) id<LDNestedViewListViewProtocol> currentListView;

@end

@implementation LDNestedView

- (instancetype)initWithDelegate:(id<LDNestedViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _mainTableView = [[LDNestedMainTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.gestureDelegate = self;
    self.mainTableView.tableHeaderView = [self.delegate tableHeaderViewInPagerView:self];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.mainTableView];
    
    _listContainerView = [[LDNestedListContainerView alloc] initWithDelegate:self];
    self.listContainerView.mainTableView = self.mainTableView;
    
    [self configListViewDidScrollCallback];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.mainTableView.frame = self.bounds;
}

- (void)reloadData {
    self.currentListView = nil;
    self.currentScrollingListView = nil;
    [self configListViewDidScrollCallback];
    [self.mainTableView reloadData];
    [self.listContainerView reloadData];
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView {
    if (self.mainTableView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagerView:self]) {
        //mainTableView的header还没有消失，让listScrollView一直为0
        if (self.currentListView && [self.currentListView respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
            [self.currentListView listScrollViewWillResetContentOffset];
        }
        if (scrollView.contentOffset.y > 0 || !self.currentListView.isSupportTheRefresh) {
            scrollView.contentOffset = CGPointZero;
        }
        scrollView.showsVerticalScrollIndicator = NO;
        if ([self.delegate respondsToSelector:@selector(mainTableViewHeaderDidHiddenInPagerView:)]) {
            [self.delegate mainTableViewHeaderDidHiddenInPagerView:self];
        }
    }else {
        //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagerView:self]);
        scrollView.showsVerticalScrollIndicator = YES;
        if ([self.delegate respondsToSelector:@selector(mainTableViewHeaderDidShowInPagerView:)]) {
            [self.delegate mainTableViewHeaderDidShowInPagerView:self];
        }
    }
}

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView {
    if (self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > 0) {
        //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagerView:self]);
    }
    
    if (scrollView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagerView:self]) {
        //mainTableView已经显示了header，listView的contentOffset需要重置
        NSArray *listViews = [self.delegate listViewsInPagerView:self];
        for (id<LDNestedViewListViewProtocol> listView in listViews) {
            if ([listView respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
                [listView listScrollViewWillResetContentOffset];
            }
            [listView listScrollView].contentOffset = CGPointZero;
        }
    }
    
    if (scrollView.contentOffset.y > [self.delegate tableHeaderViewHeightInPagerView:self] && self.currentScrollingListView.contentOffset.y == 0) {
        //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagerView:self]);
    }
}

#pragma mark - Private

- (void)configListViewDidScrollCallback {
    NSArray *listViews = [self.delegate listViewsInPagerView:self];
    for (id<LDNestedViewListViewProtocol> listView in listViews) {
        __weak typeof(self)weakSelf = self;
        [listView listViewDidScrollCallback:^(UIScrollView *scrollView) {
            weakSelf.currentListView = listView;
            [weakSelf listViewDidScroll:scrollView];
        }];
    }
}

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    self.currentScrollingListView = scrollView;
    
    [self preferredProcessListViewDidScroll:scrollView];
}

- (void)setCurrentScrollingListView:(UIScrollView *)currentScrollingListView {
    _currentScrollingListView = currentScrollingListView;
    self.mainTableView.bounces = !self.currentListView.isSupportTheRefresh;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size.height - [self.delegate heightForPinSectionHeaderInPagerView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.listContainerView.frame = cell.contentView.bounds;
    [cell.contentView addSubview:self.listContainerView];
    [self.listContainerView setNeedsLayout];
    [self.listContainerView layoutIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.delegate heightForPinSectionHeaderInPagerView:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.delegate viewForPinSectionHeaderInPagerView:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(mainTableViewDidScroll:)]) {
        [self.delegate mainTableViewDidScroll:scrollView];
    }
    
    if (scrollView.isTracking) {
        self.listContainerView.collectionView.scrollEnabled = NO;
    }
    
    [self preferredProcessMainTableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.listContainerView.collectionView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.listContainerView.collectionView.scrollEnabled = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.listContainerView.collectionView.scrollEnabled = YES;
}

#pragma mark - IQHPagingListContainerViewDelegate

- (NSInteger)numberOfRowsInListContainerView:(LDNestedListContainerView *)listContainerView {
    NSArray *listViews = [self.delegate listViewsInPagerView:self];
    return listViews.count;
}

- (UIView *)listContainerView:(LDNestedListContainerView *)listContainerView listViewInRow:(NSInteger)row {
    NSArray *listViews = [self.delegate listViewsInPagerView:self];
    return [listViews[row] listView];
}

- (void)listContainerView:(LDNestedListContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row {
    NSArray *listViews = [self.delegate listViewsInPagerView:self];
    self.currentListView = listViews[row];
    self.currentScrollingListView = [listViews[row] listScrollView];
    if ([self.delegate respondsToSelector:@selector(listContainerViewWillDisplayCellAtRow:)]) {
        [self.delegate listContainerViewWillDisplayCellAtRow:row];
    }
}


- (void)listContainerView:(LDNestedListContainerView *)listContainerView didEndDisplayingCell:(NSInteger)row{
    
}


#pragma mark - tableHeaderView中的滑动视图与mainTableView的滑动手势冲突
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.listContainerView];
    if (CGRectContainsPoint(self.listContainerView.frame, touchPoint)) {
        return YES;
    }
    return NO;
}

@end
