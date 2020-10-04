//
//  MerchantSearchResultVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantSearchResultVC.h"
#import "SGPageTitleView.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageContentScrollView.h"
#import "MerchantSearchChildVC.h"
#import "HomeSearchHistoryCollectionViewCell.h"

@interface MerchantSearchResultVC ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)SGPageContentScrollView *mPageContentScrollView;
@property(nonatomic,weak)SGPageTitleView *mPageTitleView;

@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *vcs;
@property(nonatomic,assign)NSInteger selectedPage;

//历史
@property (weak, nonatomic) IBOutlet UICollectionView *historyCollect;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIView *historyBgView;

//结果view
@property (weak, nonatomic) IBOutlet UIView *resultView;

@end

@implementation MerchantSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHistoryView];
    [self loadVCs];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addHistoryView{
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 50)/3, 30);
    self.flowLayout.minimumLineSpacing = 15;
    self.flowLayout.minimumInteritemSpacing = 15;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.historyCollect registerNib:[UINib nibWithNibName:@"HomeSearchHistoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSearchHistoryCollectionViewCell"];
    self.historyBgView.hidden = YES;
}

-(void)prepareUi{
    [self.mPageContentScrollView removeFromSuperview];
    [self.mPageTitleView removeFromSuperview];
    
    //配置容器
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = YES;
    configure.indicatorHeight = 2.0f;
    configure.indicatorFixedWidth = 30.f;
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.indicatorColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.titleSelectedColor = [UIColor colorWithRGBHex:@"#333333"];
    configure.titleSelectedFont = [UIFont fontWithName:@"PingFang-SC-Bold" size:17];
    configure.titleColor = [UIColor colorWithRGBHex:@"#AAA5AF"];
    configure.titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    configure.indicatorToBottomDistance = 5.0f;
    configure.showBottomSeparator = NO;
    
    //顶部Title数据源
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, ksrcwidth, 45) delegate:self titleNames:self.titles configure:configure];
    pageTitleView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    _mPageTitleView = pageTitleView;
    pageTitleView.selectedIndex = self.selectedPage;
    [self.resultView addSubview:pageTitleView];
    
    SGPageContentScrollView *pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pageTitleView.frame)+ 10,ksrcwidth,self.view.height - statusHeight - 60) parentVC:self childVCs:[self.vcs copy]];
    pageContentScrollView.delegatePageContentScrollView = self;
    pageContentScrollView.isAnimated = NO;
    pageContentScrollView.backgroundColor = [UIColor whiteColor];
    _mPageContentScrollView = pageContentScrollView;
    [self.resultView addSubview:pageContentScrollView];
    for (int b=0; b<self.vcs.count; b++) {//全部加载出来
        [pageContentScrollView setPageContentScrollViewCurrentIndex:b];
    }
    pageTitleView.selectedIndex = self.selectedPage;
    [pageContentScrollView setPageContentScrollViewCurrentIndex:self.selectedPage];
}

-(void)loadVCs{
    for (int i = 0; i<self.titles.count; i++) {
        MerchantSearchChildVC *childVC = [[MerchantSearchChildVC alloc] init];
//        childVC.navigation = self.navigationController;
        [self.vcs addObject:childVC];
    }
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

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSearchHistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSearchHistoryCollectionViewCell" forIndexPath:indexPath];
    return cell;
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
        _titles = [NSArray arrayWithObjects:NSLocalizedString(@"商家", nil),NSLocalizedString(@"商品", nil), nil];
    }
    return _titles;
}

@end
