//
//  MerchantAtlasVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/6.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantAtlasVC.h"
#import "MerchantAtlasCollectionViewCell.h"

@interface MerchantAtlasVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation MerchantAtlasVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 30)/2, 116);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"MerchantAtlasCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MerchantAtlasCollectionViewCell"];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MerchantAtlasCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchantAtlasCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

@end
