//
//  LDItemViewControl.h
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDItemsConfig : NSObject

@property(nonatomic,assign)float itemWidth;        //default is 0
@property(nonatomic,strong)UIFont *itemFont;       //default is 16
@property(nonatomic,strong)UIColor *textColor;     //default is COLOR_Gray_Dark
@property(nonatomic,strong)UIColor *selectedColor; //default is COLOR_Green
@property(nonatomic,strong)UIFont *selectedFont; //default is 18

@property(nonatomic,assign)float linePercent;  //default is 0.8
@property(nonatomic,assign)float lineHieght;   //default is 2.5
@property(nonatomic,assign)float lineMarginBottom;   //default is 0


@end

typedef void (^LDItemsControlViewTapBlock)(NSInteger index,BOOL animation);

@interface LDItemViewControl : UIScrollView

@property(nonatomic,strong)LDItemsConfig *config;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,assign)BOOL tapAnimation;//default is YES;
@property(nonatomic,assign)BOOL isShowLine; //default is YES;
@property(nonatomic,readonly)NSInteger currentIndex;
@property(nonatomic,copy)LDItemsControlViewTapBlock tapItemWithIndex;


-(void)moveToIndex:(float)index; //called in scrollViewDidScroll
/*
 首次出现，需要高亮显示第二个元素,scroll: 是外部关联的scroll
 [self endMoveToIndex:2];
 [scroll scrollRectToVisible:CGRectMake(2*w, 0.0, w,h) animated:NO];
 */
-(void)endMoveToIndex:(float)index;  //called in scrollViewDidEndDecelerating

@end

NS_ASSUME_NONNULL_END
