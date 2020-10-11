//
//  MineCollectionVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineCollectionVC.h"
#import "SGPageTitleView.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageContentScrollView.h"
#import "MineCollectShopVC.h"
#import "MineCollectPostVC.h"

@interface MineCollectionVC ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>

@property(nonatomic,weak)SGPageContentScrollView *mPageContentScrollView;
@property(nonatomic,weak)SGPageTitleView *mPageTitleView;

@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *vcs;
@property(nonatomic,assign)NSInteger selectedPage;

@end

@implementation MineCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadVCs];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    [self.mPageContentScrollView removeFromSuperview];
    [self.mPageTitleView removeFromSuperview];
    
    //配置容器
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = NO;
    configure.indicatorHeight = 2.5;
    configure.indicatorStyle = SGIndicatorStyleDefault;
    configure.indicatorColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.titleSelectedColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.titleSelectedFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    configure.titleColor = [UIColor colorWithRGBHex:@"#AAA5AF"];
    configure.titleFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    configure.showBottomSeparator = NO;
    
    //顶部Title数据源
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, statusHeight + 53, ksrcwidth, 45) delegate:self titleNames:self.titles configure:configure];
    pageTitleView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    _mPageTitleView = pageTitleView;
    pageTitleView.selectedIndex = self.selectedPage;
    [self.view addSubview:pageTitleView];
    
    SGPageContentScrollView *pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pageTitleView.frame),ksrcwidth,self.view.height - statusHeight - 45 - 53) parentVC:self childVCs:[self.vcs copy]];
    pageContentScrollView.delegatePageContentScrollView = self;
    pageContentScrollView.isAnimated = NO;
    pageContentScrollView.backgroundColor = [UIColor whiteColor];
    _mPageContentScrollView = pageContentScrollView;
    [self.view addSubview:pageContentScrollView];
    for (int b=0; b<self.vcs.count; b++) {//全部加载出来
        [pageContentScrollView setPageContentScrollViewCurrentIndex:b];
    }
    pageTitleView.selectedIndex = self.selectedPage;
    [pageContentScrollView setPageContentScrollViewCurrentIndex:self.selectedPage];
}

-(void)loadVCs{
    MineCollectShopVC *shop = [[MineCollectShopVC alloc] init];
    [self.vcs addObject:shop];
    
    MineCollectPostVC *post = [[MineCollectPostVC alloc] init];
    [self.vcs addObject:post];
}

//顶部title切换完成调用
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex{
    [_mPageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
    self.selectedPage=selectedIndex;
}

//内容区域滚动后调用
-(void)scrollCompleteDeleate:(NSInteger)index{
    self.selectedPage=index;
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [_mPageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index{
    NSLog(@"点击%ld",(long)index);
}

-(void)pageContentScrollViewDidEndDecelerating:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index{
    NSLog(@"滚动%ld",(long)index);
    self.selectedPage=index;
}

#pragma -mark getter
-(NSMutableArray *)vcs{
    if (!_vcs) {
        _vcs = [NSMutableArray array];
    }
    return _vcs;
}

-(NSArray *)titles{
    if (!_titles) {
        _titles = [NSArray arrayWithObjects:NSLocalizedString(@"商家", nil),NSLocalizedString(@"贴子", nil), nil];
    }
    return _titles;
}

@end
