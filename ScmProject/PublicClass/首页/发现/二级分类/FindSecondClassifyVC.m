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
#import "FindTitleDetailVC.h"

@interface FindSecondClassifyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,LMHWaterFallLayoutDelegate>{
    int page;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation FindSecondClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addRefresh];
    [self.collectView.mj_header beginRefreshing];
    [self getClassifyDetail];
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
    
    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        FindTitleDetailVC *detail = [[FindTitleDetailVC alloc] init];
        detail.titleStr = NSLocalizedString(@"详情", nil);
        detail.model = weakself.model;
        [weakself.navigationController pushViewController:detail animated:YES];
    }];
    [self.topView addGestureRecognizer:tap];
    
    self.titleLabel.text = AssectString(self.model.name);
    [self.headV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(self.model.link)]]];
}

-(void)addRefresh{
    WeakSelf(self);
    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData:YES];
    }];
    self.collectView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getData:NO];
    }];
}

#pragma -mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item];
    return cell;
}

#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    HomeNewModel *model = self.datas[indexPath];
    return 285 + model.height;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 10;
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 2;
}

-(void)getData:(BOOL)ifFresh{
    ifFresh?(page = 1):(page ++);
    UserModel *userModel = [Manager takeoutUserTokenkey:Loginuser];
    NSDictionary *dict = @{
      @"categoryId": AssectString(self.model.categoryId),
      @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
      @"userId": AssectString(userModel.userId)
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"post/homeupfindcategorypost/" body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            ifFresh?[weakself.datas removeAllObjects]:nil;
            [result[resultData] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeNewModel *model = [HomeNewModel mj_objectWithKeyValues:obj];
                model.height = [weakself calculateHeight:AssectString(model.title)];
                [weakself.datas addObject:model];
            }];
            [self.collectView reloadData];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
    [self.collectView.mj_header endRefreshing];
    [self.collectView.mj_footer endRefreshing];
}

-(void)getClassifyDetail{
    NSDictionary *dict = @{
      @"id": AssectString(self.model.categoryId)
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"post/homeupfindcategorydetails/" body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            weakself.model = [HomeFindCategorysModel mj_objectWithKeyValues:result[resultData]];
            weakself.nameLabel.text = result[resultData][@"name"];
            weakself.descLabel.text = result[resultData][@"description"];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(CGFloat)calculateHeight:(NSString *)title{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:13] forKey:NSFontAttributeName];
    CGFloat width = (ksrcwidth - 30)/2 - 20;
    CGSize size = [title boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height - 16.f;
}

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
