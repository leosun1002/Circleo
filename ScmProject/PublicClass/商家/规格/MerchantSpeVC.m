//
//  MerchantSpeVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/5.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantSpeVC.h"
#import "MerchantSpecCollectionViewCell.h"

@interface MerchantSpeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;

@end

@implementation MerchantSpeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self prepareUi];
}

-(void)prepareUi{
    WeakSelf(self);
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 70)/4, 30);
    self.flowLayout.headerReferenceSize = CGSizeMake(ksrcwidth - 20, 50);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"MerchantSpecCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MerchantSpecCollectionViewCell"];
    [self.collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionHeader"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           weakself.bottomConst.constant = 10;
           [UIView animateWithDuration:0.25 animations:^{
               [weakself.view layoutIfNeeded];
           }];
       });
}

- (IBAction)closeClick:(id)sender {
    self.bottomConst.constant = -440;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionHeader" forIndexPath:indexPath];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ksrcwidth - 10, 50)];
    label.text = @"套餐类型";
    label.textColor = [UIColor colorWithRGBHex:@"#333333"];
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [view addSubview:label];
    return view;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MerchantSpecCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchantSpecCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
@end
