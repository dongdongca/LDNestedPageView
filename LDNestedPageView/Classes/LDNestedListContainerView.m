//
//  LDNestedListContainerView.m
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import "LDNestedListContainerView.h"

@interface LDNestedListContainerView () <UICollectionViewDelegate, UICollectionViewDataSource>
/// collectionView
@property (nonatomic, strong) LDNestedListContainerCollectionView *collectionView;
@end

@implementation LDNestedListContainerView
/// 初始化方法
- (instancetype)initWithDelegate:(id<LDNestedListContainerViewDelegate>)delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        [self initializeViews];
    }
    return self;
}

/// 初始化subviews
- (void)initializeViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[LDNestedListContainerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:self.collectionView];
}

/// 刷新collection
- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDelegate
/// cell将要显示
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(listContainerView:willDisplayCellAtRow:)]) {
        [self.delegate listContainerView:self willDisplayCellAtRow:indexPath.item];
    }
}

/// cell将要消失
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(listContainerView:didEndDisplayingCell:)]) {
        [self.delegate listContainerView:self didEndDisplayingCell:indexPath.item];
    }
}

/// 当滚动视图停止时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.mainTableView.scrollEnabled = YES;
}

/// 用户手动减速，后继续滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.mainTableView.scrollEnabled = YES;
}

/// 滚动动画结束时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.mainTableView.scrollEnabled = YES;
}

/// 将要滚动式，禁用mainTableView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isTracking || scrollView.isDecelerating) {
        self.mainTableView.scrollEnabled = NO;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
/// 返回cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.delegate numberOfRowsInListContainerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *listView = [self.delegate listContainerView:self listViewInRow:indexPath.item];
    listView.frame = cell.contentView.bounds;
    [cell.contentView addSubview:listView];
    
    return cell;
}

@end
