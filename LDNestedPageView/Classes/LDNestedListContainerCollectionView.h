//
//  LDNestedListContainerCollectionView.h
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDNestedListContainerCollectionView;

NS_ASSUME_NONNULL_BEGIN

@protocol LDNestedListContainerCollectionViewGestureDelegate <NSObject>
/// 处理手势问题
- (BOOL)pagerListContainerCollectionViewGestureRecognizerShouldBegin:(LDNestedListContainerCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end

@interface LDNestedListContainerCollectionView : UICollectionView
/// 是否启用嵌套
@property (nonatomic, assign) BOOL isNestEnabled;
/// 处理手势问题的代理方法
@property (nonatomic, weak) id<LDNestedListContainerCollectionViewGestureDelegate> gestureDelegate;
@end

NS_ASSUME_NONNULL_END
