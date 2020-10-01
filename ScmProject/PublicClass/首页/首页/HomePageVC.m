//
//  HomePageVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomePageVC.h"
#import "SGPageTitleView.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageContentScrollView.h"
#import "HomePageChildVC.h"
#import "HomeFindVC.h"
#import "FindClassifyVC.h"

@interface HomePageVC ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;

@property(nonatomic,weak)SGPageContentScrollView *mPageContentScrollView;
@property(nonatomic,weak)SGPageTitleView *mPageTitleView;

@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *vcs;
@property(nonatomic,assign)NSInteger selectedPage;

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadVCs];
    [self prepareUi];
}

-(void)prepareUi{
    [self.mPageContentScrollView removeFromSuperview];
    [self.mPageTitleView removeFromSuperview];
    
    //配置容器
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = NO;
    configure.indicatorAdditionalWidth = 32.f;
    configure.indicatorHeight = 33.f;
    configure.indicatorCornerRadius = 16.5f;
    configure.indicatorStyle = SGIndicatorStyleCover;
    configure.indicatorColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.titleSelectedColor = [UIColor colorWithRGBHex:@"#FFFFFF"];
    configure.titleSelectedFont = [UIFont fontWithName:@"PingFang-SC-Bold" size:17];
    configure.titleColor = [UIColor colorWithRGBHex:@"#AAA5AF"];
    configure.titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
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
    for (int i = 0; i<self.titles.count; i++) {
        if (i == self.titles.count - 1) {
            HomeFindVC *findVC = [[HomeFindVC alloc] init];
            findVC.subject = [RACSubject subject];
            WeakSelf(self);
            [findVC.subject subscribeNext:^(id x) {
                FindClassifyVC *classify = [[FindClassifyVC alloc] init];
                [weakself.navigationController pushViewController:classify animated:YES];
            }];
            [self.vcs addObject:findVC];
        }else{
            HomePageChildVC *childVC = [[HomePageChildVC alloc] init];
            childVC.navigation = self.navigationController;
            [self.vcs addObject:childVC];
        }
    }
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        _titles = [NSArray arrayWithObjects:NSLocalizedString(@"关注", nil),NSLocalizedString(@"最新", nil),NSLocalizedString(@"附近", nil),NSLocalizedString(@"发现", nil), nil];
    }
    return _titles;
}

@end
