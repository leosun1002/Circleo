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
#import "HomeFindModel.h"

@interface HomeFindVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (assign, nonatomic) BOOL hasRefresh;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation HomeFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addRefresh];
}

-(void)refreshData{
    if (!self.hasRefresh) {
        [self.collectView.mj_header beginRefreshing];
        self.hasRefresh = YES;
    }
}

-(void)addRefresh{
    WeakSelf(self);
    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData];
    }];
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
    return self.datas.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    HomeFindModel *model = self.datas[section];
    return model.postCategorys.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeFindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFindCollectionViewCell" forIndexPath:indexPath];
    HomeFindModel *model = self.datas[indexPath.section];
    HomeFindCategorysModel *category = model.postCategorys[indexPath.item];
    cell.nameLabel.text = AssectString(category.name);
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(category.link)]]];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeFindModel *model = self.datas[indexPath.section];
        HomeFidHeaderReusableView *homeHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFidHeaderReusableView" forIndexPath:indexPath];
        homeHeader.nameLabel.text = AssectString(model.name);
        return homeHeader;
    }
    HomeFindFooterReusableView *homeFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeFindFooterReusableView" forIndexPath:indexPath];
    return homeFooter;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeFindModel *model = self.datas[indexPath.section];
    HomeFindCategorysModel *category = model.postCategorys[indexPath.item];
    [self.subject sendNext:category];
}

-(void)getData{
    WeakSelf(self);
    [WebServices postWithUrl:@"post/homeupfind/" body:@{} loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            NSMutableArray<HomeFindModel*> *applicationList = [HomeFindModel mj_objectArrayWithKeyValuesArray:result[resultData]];
            weakself.datas = applicationList;
            [weakself.collectView reloadData];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
    [self.collectView.mj_header endRefreshing];
}

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
