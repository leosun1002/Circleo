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
#import "HomeNewModel.h"

@interface HomeUserInfoChildView ()<LMHWaterFallLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    int page;
}

@property (nonatomic,strong) UICollectionView *collectview;
@property (nonatomic, assign) BOOL hasRefresh;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation HomeUserInfoChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
        [self prepareUi];
        [self addRefresh];
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

-(void)refreshData{
    if (!self.hasRefresh) {
        [self.collectview.mj_header beginRefreshing];
        self.hasRefresh = YES;
    }
}

-(void)addRefresh{
    WeakSelf(self);
    self.collectview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData:YES];
    }];
    self.collectview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getData:NO];
    }];
}

-(void)getData:(BOOL)ifFresh{
    ifFresh?(page = 1):(page ++);
    UserModel *userModel = [Manager takeoutUserTokenkey:Loginuser];
    NSDictionary *dict = @{};
    WeakSelf(self);
    NSString *url = @"";
    if (self.type == 0) {
        url = @"my/mycenterpost/";
        dict = @{
          @"name": @"",
          @"pageNo": [NSString stringWithFormat:@"%d",page],
          @"pageSize": PageSize,
          @"userId": AssectString(userModel.userId)
        };
    }else if (self.type == 1){
        url = @"my/mycenterpostlike/";
        dict = @{
          @"name": @"",
          @"pageNo": [NSString stringWithFormat:@"%d",page],
          @"pageSize": PageSize,
          @"userId": AssectString(userModel.userId)
        };
    }
    [WebServices postWithUrl:url body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            ifFresh?[weakself.datas removeAllObjects]:nil;
            [result[resultData] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeNewModel *model = [HomeNewModel mj_objectWithKeyValues:obj];
                model.height = [weakself calculateHeight:AssectString(model.title)];
                [weakself.datas addObject:model];
            }];
            [self.collectview reloadData];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
    [self.collectview.mj_header endRefreshing];
    [self.collectview.mj_footer endRefreshing];
}

-(CGFloat)calculateHeight:(NSString *)title{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:13] forKey:NSFontAttributeName];
    CGFloat width = (ksrcwidth - 30)/2 - 20;
    CGSize size = [title boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height - 16.f;
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
