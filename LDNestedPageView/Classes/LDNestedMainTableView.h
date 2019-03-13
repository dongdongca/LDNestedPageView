//
//  LDNestedMainTableView.h
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LDNestedMainTableViewGestureDelegate <NSObject>

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end

@interface LDNestedMainTableView : UITableView
///手势处理代理
@property (nonatomic, weak) id<LDNestedMainTableViewGestureDelegate> gestureDelegate;

@end

NS_ASSUME_NONNULL_END
