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
#import "HomeLongPressVC.h"
#import "HomeNewModel.h"

@interface HomePageChildVC ()<UICollectionViewDelegate,UICollectionViewDataSource,LMHWaterFallLayoutDelegate>{
    int page;
}

@property (nonatomic, weak) UICollectionView * collectionView;
@property (nonatomic, assign) BOOL hasRefresh;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation HomePageChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addRefresh];
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

-(void)addRefresh{
    WeakSelf(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData:YES];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getData:NO];
    }];
}

-(void)refreshData{
    if (!self.hasRefresh) {
        [self.collectionView.mj_header beginRefreshing];
        self.hasRefresh = YES;
    }
}

-(void)showUnlikeVC{
    HomeLongPressVC *longVC = [[HomeLongPressVC alloc] init];
    longVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    longVC.subject = [RACSubject subject];
    WeakSelf(self);
    [longVC.subject subscribeNext:^(id x) {
        [weakself jubaoClick];
    }];
    [self presentViewController:longVC animated:NO completion:^{
        
    }];
}

-(void)jubaoClick{
    UIAlertController*   sheetVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"举报", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
    UIAlertAction*  sheetBtn1=[UIAlertAction actionWithTitle:NSLocalizedString(@"政治敏感", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn1];
    [sheetBtn1 setValue:[UIColor colorWithRGBHex:@"#333333"] forKey:@"titleTextColor"];
    
    UIAlertAction*  sheetBtn2=[UIAlertAction actionWithTitle:NSLocalizedString(@"违法犯罪", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn2];
    [sheetBtn2 setValue:[UIColor colorWithRGBHex:@"#333333"] forKey:@"titleTextColor"];
    
    UIAlertAction*  sheetBtn3=[UIAlertAction actionWithTitle:NSLocalizedString(@"侮辱谩骂", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn3];
    [sheetBtn3 setValue:[UIColor colorWithRGBHex:@"#333333"] forKey:@"titleTextColor"];
    
    UIAlertAction*  sheetBtn4=[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn4];
    [sheetBtn4 setValue:[UIColor colorWithRGBHex:@"#999999"] forKey:@"titleTextColor"];
    
    [self presentViewController:sheetVC animated:YES completion:nil];
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"举报", nil)];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:15.0]
                  range:NSMakeRange(0, NSLocalizedString(@"举报", nil).length)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithRGBHex:@"#333333"]
                  range:NSMakeRange(0, NSLocalizedString(@"举报", nil).length)];
    [sheetVC setValue:hogan forKey:@"attributedTitle"];

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
    cell.subject = [RACSubject subject];
    WeakSelf(self);
    [cell.subject subscribeNext:^(id x) {
        [weakself showUnlikeVC];
    }];
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
    NSDictionary *dict = @{};
    WeakSelf(self);
    NSString *url = @"";
    if (self.type == 0) {
        url = @"post/homeattention/";
        dict = @{
          @"name": @"",
          @"pageNo": [NSString stringWithFormat:@"%d",page],
          @"pageSize": PageSize,
          @"userId": AssectString(userModel.userId)
        };
    }else if (self.type == 1){
        url = @"post/homeuptodate/";
        dict = @{
          @"name": @"",
          @"pageNo": [NSString stringWithFormat:@"%d",page],
          @"pageSize": PageSize,
          @"userId": AssectString(userModel.userId)
        };
    }else if (self.type == 2){
        url = @"post/homenear/";

    }
    [WebServices postWithUrl:url body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            ifFresh?[weakself.datas removeAllObjects]:nil;
            [result[resultData] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeNewModel *model = [HomeNewModel mj_objectWithKeyValues:obj];
                model.height = [weakself calculateHeight:AssectString(model.title)];
                [weakself.datas addObject:model];
            }];
            [self.collectionView reloadData];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
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
