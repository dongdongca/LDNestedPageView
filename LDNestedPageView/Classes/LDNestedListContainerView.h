//
//  LDNestedListContainerView.h
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDNestedListContainerCollectionView.h"
#import "LDNestedMainTableView.h"
@class LDNestedListContainerView;

NS_ASSUME_NONNULL_BEGIN

@protocol LDNestedListContainerViewDelegate <NSObject>

/**
 * @brief 返会collection的item的个数.
 *
 * @param listContainerView 容器view.
 *
 * @return item的个数.
 */
- (NSInteger)numberOfRowsInListContainerView:(LDNestedListContainerView *)listContainerView;

/**
 * @brief 返会当前item中要填加的listView.
 *
 * @param listContainerView 容器view.
 *
 * @param row 当前item的索引.
 *
 * @return 要填的view.
 */
- (UIView *)listContainerView:(LDNestedListContainerView *)listContainerView listViewInRow:(NSInteger)row;

/**
 * @brief collectionView的item将要显示的时候调用.
 *
 * @param listContainerView 容器view.
 *
 * @param row 当前item的索引.
 */
- (void)listContainerView:(LDNestedListContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row;

/**
 * @brief collectionView的item将要消失的时候调用.
 *
 * @param listContainerView 容器view.
 *
 * @param row 当前item的索引.
 */
- (void)listContainerView:(LDNestedListContainerView *)listContainerView didEndDisplayingCell:(NSInteger)row;

@end

@interface LDNestedListContainerView : UIView

/// 容器view的collection
@property (nonatomic, strong, readonly) LDNestedListContainerCollectionView *collectionView;
/// 代理
@property (nonatomic, weak) id<LDNestedListContainerViewDelegate> delegate;
/// 添加到的tableView
@property (nonatomic, weak) LDNestedMainTableView *mainTableView;
/**
 * @brief 初始化的方法.
 *
 * @param delegate 必须设置代理.
 *
 * @return LDNestedListContainerView.
 */
- (instancetype)initWithDelegate:(id<LDNestedListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

/**
 * @brief 刷新collection.
 */
- (void)reloadData;

/// 禁用其他初始化方法
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


@end

NS_ASSUME_NONNULL_END
