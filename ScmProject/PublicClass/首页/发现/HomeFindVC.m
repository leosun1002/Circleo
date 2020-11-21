//
//  HomeFindVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeFindVC.h"
#import "HomeFindCollectionViewCell.h"
#import "HomeFidHeaderReusableView.h"
#import "HomeFindFooterReusableView.h"

@interface HomeFindVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation HomeFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.collectView.layer.cornerRadius = 10.f;
    self.collectView.layer.masksToBounds = YES;
    self.heightConst.constant = ksrcheight - navBarHeight - tabbarHeight - 45 - 53;
    
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 70)/4, (ksrcwidth - 70)/4);
    self.flowLayout.headerReferenceSize = CGSizeMake(ksrcwidth - 20, 50);
    self.flowLayout.footerReferenceSize = CGSizeMake(ksrcwidth - 20, 30);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"HomeFindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeFindCollectionViewCell"];
    [self.collectView registerNib:[UINib nibWithNibName:@"HomeFidHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFidHeaderReusableView"];
    [self.collectView registerNib:[UINib nibWithNibName:@"HomeFindFooterReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeFindFooterReusableView"];
}

#pragma -mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeFindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFindCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeFidHeaderReusableView *homeHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFidHeaderReusableView" forIndexPath:indexPath];
        return homeHeader;
    }
    HomeFindFooterReusableView *homeFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeFindFooterReusableView" forIndexPath:indexPath];
    return homeFooter;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.subject sendNext:@""];
}
@end
