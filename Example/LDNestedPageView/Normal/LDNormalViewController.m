//
//  LDNormalViewController.m
//  LDNestedPageView_Example
//
//  Created by 启航龙图.在线事业部.李东 on 2019/3/13.
//  Copyright © 2019 李东. All rights reserved.
//

#import "LDNormalViewController.h"
#import "LDNestedView.h"
#import "LDNormalTableView.h"
#import "LDNormalHeaderView.h"
#import "LDNormalSectionHeaderView.h"
#import "LDItemViewControl.h"

static const CGFloat LDheightForHeaderView = 200;
static const CGFloat LDheightForHeaderInSection = 50;

@interface LDNormalViewController () <LDNestedViewDelegate>
/// 头部视图
@property (nonatomic, strong) LDNormalHeaderView *headerView;
/// 顶部固定组头
@property (nonatomic, strong) LDItemViewControl *sectionHeaderView;
/// 嵌套view
@property (nonatomic, strong) LDNestedView *nestedView;
/// 列表数组
@property (nonatomic, strong) NSArray <LDNormalTableView *> *listViewArray;
@end

@implementation LDNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubview];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
        self.nestedView.frame = self.view.bounds;
}

//设置UI
- (void)setupSubview {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    LDNormalTableView *firstVC = [[LDNormalTableView alloc] init];
    LDNormalTableView *twoVC = [[LDNormalTableView alloc] init];
    LDNormalTableView *threeVC = [[LDNormalTableView alloc] init];
    
    self.listViewArray = @[firstVC,twoVC,threeVC];
    
    //设置headerview
    self.headerView = [[LDNormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, LDheightForHeaderView)];
    
    //设置分页view
    self.nestedView = [[LDNestedView alloc] initWithDelegate:self];
    self.nestedView.frame = self.view.bounds;
    [self.view addSubview:self.nestedView];
    
    // 设置分类view
    self.sectionHeaderView = [[LDItemViewControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, LDheightForHeaderInSection)];
    LDItemsConfig *config = [[LDItemsConfig alloc] init];
    config.itemWidth = [UIScreen mainScreen].bounds.size.width / 3;
    self.sectionHeaderView.config = config;
    self.sectionHeaderView.tapAnimation = NO;
    self.sectionHeaderView.isShowLine = YES;
    self.sectionHeaderView.titleArray = @[@"first",@"two",@"three"];
    
    __weak typeof(self)weakSelf = self;
    self.sectionHeaderView.tapItemWithIndex = ^(NSInteger index, BOOL animation) {
        [weakSelf.nestedView.listContainerView.collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0) animated:YES];
    };

    
}

#pragma mark - IQHPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(LDNestedView *)nestedView {
    return self.headerView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(LDNestedView *)nestedView {
    return LDheightForHeaderView;
}
- (NSUInteger)heightForPinSectionHeaderInPagerView:(LDNestedView *)nestedView {
    return LDheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(LDNestedView *)nestedView {
    return self.sectionHeaderView;
}

- (NSArray<id<LDNestedViewListViewProtocol>> *)listViewsInPagerView:(LDNestedView *)nestedView {
    return self.listViewArray;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)mainTableViewHeaderDidHiddenInPagerView:(LDNestedView *)nestedView {
    
}

- (void)mainTableViewHeaderDidShowInPagerView:(LDNestedView *)nestedView {
    
}

@end
