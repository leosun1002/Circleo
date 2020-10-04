//
//  HomeUserInfoChildView.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeUserInfoChildView.h"
#import "LMHWaterFallLayout.h"
#import "HomePageCollectionViewCell.h"

@interface HomeUserInfoChildView ()<LMHWaterFallLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectview;

@end

@implementation HomeUserInfoChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
        [self prepareUi];
    }
    return self;
}

-(void)layoutSubviews{
    [self.collectview setFrame:self.bounds];
}

-(void)prepareUi{
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.delegate = self;
    
    // 创建collectionView
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:waterFallLayout];
    collectionView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionViewCell"];
    self.collectview = collectionView;
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

#pragma -mark JXPagerViewListViewDelegate
- (UIScrollView *)listScrollView {
    return self.collectview;
}

- (UIView *)listView {
    return self;
}

// 必须加（用于联动）
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

@end
