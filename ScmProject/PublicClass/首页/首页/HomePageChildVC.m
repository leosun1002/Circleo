//
//  HomePageChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomePageChildVC.h"
#import "HomePageCollectionViewCell.h"
#import "LMHWaterFallLayout.h"
#import "HomeGraphicDetailVC.h"
#import "HomeVideoDetailVC.h"

@interface HomePageChildVC ()<UICollectionViewDelegate,UICollectionViewDataSource,LMHWaterFallLayoutDelegate>

@property (nonatomic, weak) UICollectionView * collectionView;

@end

@implementation HomePageChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.delegate = self;
    
    // 创建collectionView
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ksrcwidth, ksrcheight - navBarHeight - tabbarHeight - 45 - 53) collectionViewLayout:waterFallLayout];
    collectionView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionViewCell"];
    self.collectionView = collectionView;
}

#pragma -mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item%2 == 0) {
        HomeGraphicDetailVC *graphic = [[HomeGraphicDetailVC alloc] init];
        [self.navigation pushViewController:graphic animated:YES];
    }else{
        HomeVideoDetailVC *detail = [[HomeVideoDetailVC alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    return indexPath % 2 == 0?320:300;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 10;
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 2;
}

@end
