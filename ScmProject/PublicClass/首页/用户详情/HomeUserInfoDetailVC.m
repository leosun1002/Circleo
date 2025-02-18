//
//  HomeUserInfoDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeUserInfoDetailVC.h"
// 头部View高
#define JXTableHeaderViewHeight 240
// 菜单项View高
#define JXheightForHeaderInSection 60

#import "JXPagerListRefreshView.h"
#import "JXCategoryView.h"
#import "HomeUserInfoChildView.h"
#import "HomeUserInfoHeader.h"
#import "FansFollowListVC.h"
#import "PopView.h"
#import "FEexChooseRecordView.h"

@interface HomeUserInfoDetailVC ()<JXPagerViewDelegate, JXCategoryViewDelegate>

/**
 顶部View（自定义View）
 */
@property (nonatomic,strong) HomeUserInfoHeader *detailHeader;
/**
 菜单项View
 */
@property (nonatomic,strong) JXCategoryTitleView *categoryView;
/**
 内容View
 */
@property (nonatomic, strong) JXPagerListRefreshView *pagingView;
/**
 菜单项标题数组
 */
@property (nonatomic,copy) NSArray *itemArr;

@property (nonatomic, strong) FEexChooseRecordView *popView;

@end

@implementation HomeUserInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareUi];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    [self.view addSubview:self.pagingView];
}

-(void)fansClick{
    FansFollowListVC *fans = [[FansFollowListVC alloc] init];
    fans.titleStr = NSLocalizedString(@"粉丝列表", nil);
    [self.navigationController pushViewController:fans animated:YES];
}

- (IBAction)showPopClick:(id)sender {
    PopView *popView = [PopView popUpContentView:self.popView direct:PopViewDirection_PopUpBottom onView:sender offset:0 triangleView:nil animation:YES];
    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

#pragma mark - JXPagingViewDelegate
/**
 自定义头部视图
 */
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.detailHeader;
}
/**
 自定义头部视图高
 
 @param pagerView pagerView
 @return 头部视图高
 */
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}
/**
 菜单项View
 
 @param pagerView pagerView
 @return 菜单项View
 */
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}
/**
 菜单项View高
 
 @param pagerView pagerView
 @return 菜单项View高
 */
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}
/**
 上下滚动后调用
 */
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    //计算偏移量
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.itemArr.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    HomeUserInfoChildView *childview = [[HomeUserInfoChildView alloc] init];
    return childview;
}

-(void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index{
    //请务必实现该方法
    //因为底层触发列表加载是在代理方法：`- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath`回调里面
    //所以，如果当前有5个item，当前在第1个，用于点击了第5个。categoryView默认是通过设置contentOffset.x滚动到指定的位置，这个时候有个问题，就会触发中间2、3、4的cellForItemAtIndexPath方法。
    //如此一来就丧失了延迟加载的功能
    //所以，如果你想规避这样的情况发生，那么务必按照这里的方法处理滚动。
    [self.pagingView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    //如果你想相邻的两个item切换时，通过有动画滚动实现。未相邻的两个item直接切换，可以用下面这段代码
    /*
     NSInteger diffIndex = labs(categoryView.selectedIndex - index);
     if (diffIndex > 1) {
     [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
     }else {
     [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
     }
     */
}

#pragma mark - JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark 懒加载
/**
 总视图
 */
-(JXPagerListRefreshView *)pagingView{
    if(!_pagingView){
        //
        _pagingView = [[JXPagerListRefreshView alloc] initWithDelegate:self];
        _pagingView.frame = CGRectMake(0, navBarHeight, ksrcwidth, ksrcheight - navBarHeight);
    }
    return _pagingView;
}

/**
 自定义头部视图
 */
-(HomeUserInfoHeader *)detailHeader{
    if(!_detailHeader){
        _detailHeader = [[HomeUserInfoHeader alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, JXTableHeaderViewHeight)];
        _detailHeader.subject = [RACSubject subject];
        WeakSelf(self);
        [_detailHeader.subject subscribeNext:^(id x) {
            [weakself fansClick];
        }];
    }
    return _detailHeader;
}

/**
 菜单项视图View
 */
-(JXCategoryTitleView *)categoryView{
    if(!_categoryView){
        //
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, JXheightForHeaderInSection)];
        // dele
        _categoryView.delegate = self;
        // 设置菜单项标题数组
        _categoryView.titles = self.itemArr;
        // 背景色
        _categoryView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
        // 标题色、标题选中色、标题字体、标题选中字体
        _categoryView.titleColor = [UIColor colorWithRGBHex:@"#AAA5AF"];
        _categoryView.titleSelectedColor = [UIColor whiteColor];
        _categoryView.titleFont = [UIFont boldSystemFontOfSize:17];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
        // 标题色是否渐变过渡
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.titleLabelZoomScale = 1.0f;
        
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.backgroundViewHeight = 33.f;
        backgroundView.backgroundViewWidth = 95.f;
        backgroundView.indicatorColor = [UIColor colorWithRGBHex:@"#343434"];
        _categoryView.indicators = @[backgroundView];
    
        // 联动（categoryView和pagingView）
        _categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
        // 返回上一页侧滑手势（仅在index==0时有效）
        self.navigationController.interactivePopGestureRecognizer.enabled = (_categoryView.selectedIndex == 0);
    }
    
    return _categoryView;
}

/**
 菜单项标题数组
 */
-(NSArray *)itemArr{
    if(!_itemArr){
        _itemArr=@[NSLocalizedString(@"动态", nil),NSLocalizedString(@"点赞", nil)];
    }
    return _itemArr;
}

- (FEexChooseRecordView *)popView {
    if (!_popView) {
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"FEexChooseRecordView" owner:self options:nil] firstObject];
        _popView.frame = CGRectMake(0, 0, 90, 88);
        _popView.clickBlock = ^(NSString *typeStr, NSString *typeName) {
            [PopView hidenPopView];
        };
    }
    return _popView;
}
@end
