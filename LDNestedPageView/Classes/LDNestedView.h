//
//  LDNestedView.h
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDNestedListContainerView.h"
#import "LDNestedViewListViewProtocol.h"

@class LDNestedView;

NS_ASSUME_NONNULL_BEGIN

@protocol LDNestedViewDelegate <NSObject>

/**
 返回tableHeaderView的高度，因为内部需要比对判断，只能是整型数
 
 @param pagerView pagerView description
 @return return tableHeaderView的高度
 */
- (NSUInteger)tableHeaderViewHeightInPagerView:(LDNestedView *)nestedView;

/**
 返回tableHeaderView
 
 @param pagerView pagerView description
 @return tableHeaderView
 */
- (UIView *)tableHeaderViewInPagerView:(LDNestedView *)nestedView;

/**
 返回悬浮HeaderView的高度，因为内部需要比对判断，只能是整型数
 
 @param pagerView pagerView description
 @return 悬浮HeaderView的高度
 */
- (NSUInteger)heightForPinSectionHeaderInPagerView:(LDNestedView *)nestedView;

/**
 返回悬浮HeaderView。
 
 @param pagerView pagerView description
 @return 悬浮HeaderView
 */
- (UIView *)viewForPinSectionHeaderInPagerView:(LDNestedView *)nestedView;

/**
 返回listViews，只要遵循IQHPagerViewListViewDelegate即可，无论你返回的是UIView还是UIViewController都可以。
 
 @param pagerView pagerView description
 @return listViews
 */
- (NSArray <id<LDNestedViewListViewProtocol>> *)listViewsInPagerView:(LDNestedView *)nestedView;

@optional

/**
 mainTableView的滚动回调，用于实现头图跟随缩放
 
 @param scrollView mainTableView
 */
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView;

/**
 mainTableView的headerView消失时调用
 
 @param pagerView pagerView description
 */
- (void)mainTableViewHeaderDidHiddenInPagerView:(LDNestedView *)nestedView;

/**
 mainTableView的滚动回调，用于实现头图跟随缩放
 
 @param pagerView pagerView description
 */
- (void)mainTableViewHeaderDidShowInPagerView:(LDNestedView *)nestedView;

/**
 collection的滚动，cell即将显示的时候调用
 
 @param row 要显示的cell
 */
- (void)listContainerViewWillDisplayCellAtRow:(NSInteger)row;

@end

@interface LDNestedView : UIView
/// 代理
@property (nonatomic, weak) id<LDNestedViewDelegate> delegate;
/// mainTableView
@property (nonatomic, strong, readonly) LDNestedMainTableView *mainTableView;
/// 当前容器view
@property (nonatomic, strong, readonly) LDNestedListContainerView *listContainerView;
/// 当前滚动的listView
@property (nonatomic, strong, readonly) UIScrollView *currentScrollingListView;
/// 当前显示的view
@property (nonatomic, strong, readonly) id<LDNestedViewListViewProtocol> currentListView;
/**
 * @brief 初始化方法.
 *
 * @param delegate 代理.
 */
- (instancetype)initWithDelegate:(id<LDNestedViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

/// 禁用一下的初始化方法
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData;

#pragma mark - Subclass

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView;

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
