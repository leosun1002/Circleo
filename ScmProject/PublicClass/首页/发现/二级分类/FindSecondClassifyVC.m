//
//  FindSecondClassifyVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "FindSecondClassifyVC.h"
#import "LMHWaterFallLayout.h"
#import "HomePageCollectionViewCell.h"

@interface FindSecondClassifyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,LMHWaterFallLayoutDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;

@end

@implementation FindSecondClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.topConst.constant = statusHeight;
    if (IS_IPHONEX) {
        self.heightConst.constant += 24;
    }
    
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.delegate = self;
    self.collectView.collectionViewLayout = waterFallLayout;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"HomePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionViewCell"];
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
