//
//  MerchantHomeHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantHomeHeader.h"
#import "SDCycleScrollView.h"
#import "MerchantHomeHeaderCollectionCell.h"
#import "JhPageControl.h"

@interface MerchantHomeHeader ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *scrollBgView;
@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UIView *pageView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIView *pageDotBgview;

@property (nonatomic, strong) JhPageControl *pageControl;
@end

@implementation MerchantHomeHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantHomeHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        self.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
        [self addCollect];
        [self addScrollView];
    }
    return self;
}

-(void)addCollect{
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 20)/4, 100);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       
    [self.collectView registerNib:[UINib nibWithNibName:@"MerchantHomeHeaderCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MerchantHomeHeaderCollectionCell"];
    
    [self.pageDotBgview addSubview:self.pageControl];
}

-(void)addScrollView{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ksrcwidth - 20, 200) delegate:self placeholderImage:[UIColor createColorImg:@"#FFFFFF"]];
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    cycleScrollView.showPageControl = NO;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"dot_bg_select"];
    cycleScrollView.autoScrollTimeInterval = 3.f;
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"dot_bg_unselect"];
    cycleScrollView.pageControlDotSize = CGSizeMake(4.f, 4.f);
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.layer.masksToBounds = YES;
    cycleScrollView.layer.cornerRadius = 10;
    [self.scrollBgView addSubview:_cycleScrollView = cycleScrollView];
    
    self.scrollBgView.layer.shadowColor = [UIColor colorWithRGBHex:@"#B28CF3"].CGColor;//阴影颜色
    self.scrollBgView.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
    self.scrollBgView.layer.shadowOpacity = 0.1f;//不透明度
    self.scrollBgView.layer.shadowRadius = 5;//半径
    self.scrollBgView.layer.cornerRadius = 10;
    
    [self.scrollBgView bringSubviewToFront:self.pageView];
}

#pragma -mark SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MerchantHomeHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchantHomeHeaderCollectionCell" forIndexPath:indexPath];
    return cell;
}

#pragma -mark getter
-(JhPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[JhPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 0, ksrcwidth - 40, 15);
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 4;
        _pageControl.otherColor = [UIColor colorWithRGBHex:@"#929292"];
        _pageControl.currentColor = [UIColor colorWithRGBHex:@"#333333"];
        _pageControl.PageControlContentMode = JhPageControlContentModeCenter; //设置对齐方式
        _pageControl.controlSpacing = 5.0f;  //间距
        _pageControl.marginSpacing = 0.f;  //距离初始位置 间距  默认10
        _pageControl.PageControlStyle = JhPageControlStyelDefault;//长条样式
    }
    return _pageControl;
}
@end
