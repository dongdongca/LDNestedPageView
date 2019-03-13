//
//  LDNestedViewListViewProtocol.h
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 该协议主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来的listView内的scrollView
 */
@protocol LDNestedViewListViewProtocol <NSObject>

@optional
/**
 * listView是否支持下拉刷新。
 */
@property (nonatomic, assign) BOOL isSupportTheRefresh;

/**
 * @brief 返回listView。如果是vc包裹的就是vc.view；如果是自定义view包裹的，就是自定义view自己。.
 *
 * @return UIView.
 */
- (UIView *)listView;

/**
 * @brief 返回listView内部持有的UIScrollView或UITableView或UICollectionView
 主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来
 的listView内的scrollView.
 *
 * @return listView内部持有的UIScrollView或UITableView或UICollectionView.
 */
- (UIScrollView *)listScrollView;


/**
 * @brief 当listView内部持有的UIScrollView或UITableView或UICollectionView的代理方法
 `scrollViewDidScroll`回调时，需要调用该代理方法传入的callback
 *
 * @param callback `scrollViewDidScroll`回调时调用的callback
 */
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *scrollView))callback;

@optional

/**
 * @brief 将要重置listScrollView的contentOffset
 */
- (void)listScrollViewWillResetContentOffset;

@end

NS_ASSUME_NONNULL_END
