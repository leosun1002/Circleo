//
//  LoginVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/28.
//  Copyright © 2020 session. All rights reserved.
//

#import "LoginVC.h"
#import "SGPageTitleView.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageContentScrollView.h"
#import "LoginPhoneChildVC.h"
#import "LoginEmailChildVC.h"

//注册
#import "RegisterVC.h"

@interface LoginVC ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property(nonatomic,weak)SGPageContentScrollView *mPageContentScrollView;
@property(nonatomic,weak)SGPageTitleView *mPageTitleView;

@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *vcs;
@property(nonatomic,assign)NSInteger selectedPage;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightConst.constant = navBarHeight;
    [self loadVCs];
    [self prepareUi];
}

-(void)prepareUi{
    [self.mPageContentScrollView removeFromSuperview];
    [self.mPageTitleView removeFromSuperview];
    
    //配置容器
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = YES;
    configure.indicatorFixedWidth = 84.f;
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.indicatorColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.indicatorHeight = 2.0f;
    configure.titleSelectedColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.titleSelectedFont = [UIFont fontWithName:@"PingFang-SC-Bold" size:17];
    configure.titleColor = [UIColor colorWithRGBHex:@"#AAA5AF"];
    configure.titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    configure.showBottomSeparator = NO;
    
    //顶部Title数据源
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, ksrcwidth, 45) delegate:self titleNames:self.titles configure:configure];
    pageTitleView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    _mPageTitleView = pageTitleView;
    pageTitleView.selectedIndex = self.selectedPage;
    [self.bgview addSubview:pageTitleView];
    
    SGPageContentScrollView *pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 45,ksrcwidth,ksrcheight - navBarHeight - 45) parentVC:self childVCs:[self.vcs copy]];
    pageContentScrollView.delegatePageContentScrollView = self;
    pageContentScrollView.isAnimated = NO;
    pageContentScrollView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    _mPageContentScrollView = pageContentScrollView;
    [self.bgview addSubview:pageContentScrollView];
    for (int b=0; b<self.vcs.count; b++) {//全部加载出来
        [pageContentScrollView setPageContentScrollViewCurrentIndex:b];
    }
    pageTitleView.selectedIndex = self.selectedPage;
    [pageContentScrollView setPageContentScrollViewCurrentIndex:self.selectedPage];
}

-(void)loadVCs{
    WeakSelf(self);

    LoginPhoneChildVC *phoneVC = [[LoginPhoneChildVC alloc] init];
    phoneVC.subject =  [RACSubject subject];
    [phoneVC.subject subscribeNext:^(id x) {
        [weakself registerClick];
    }];
    [self.vcs addObject:phoneVC];
    
    LoginEmailChildVC *emailVC = [[LoginEmailChildVC alloc] init];
    emailVC.subject =  [RACSubject subject];
    [emailVC.subject subscribeNext:^(id x) {
        [weakself registerClick];
    }];
    [self.vcs addObject:emailVC];
}

-(void)registerClick{
    RegisterVC *regist = [[RegisterVC alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
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
        _titles = [NSArray arrayWithObjects:NSLocalizedString(@"手机号登录", nil),NSLocalizedString(@"邮箱登录", nil), nil];
    }
    return _titles;
}
@end
