//
//  HomeSearchVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeSearchVC.h"
#import "HomeSearchHistoryCollectionViewCell.h"
#import "LMHWaterFallLayout.h"
#import "HomePageCollectionViewCell.h"

@interface HomeSearchVC ()<UICollectionViewDataSource,UICollectionViewDelegate,LMHWaterFallLayoutDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (weak, nonatomic) IBOutlet UICollectionView *historyCollect;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIView *historyBgview;

@property (strong, nonatomic) UICollectionView *searhCollect;

@end

@implementation HomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.searchBgView.layer.cornerRadius = 17.5;
    self.searchBgView.layer.shadowColor = [UIColor colorWithRGBHex:@"#B28CF3"].CGColor;//阴影颜色
    self.searchBgView.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
    self.searchBgView.layer.shadowOpacity = 0.1f;//不透明度
    self.searchBgView.layer.shadowRadius = 5;//半径
    
    [self addHistoryView];
    [self addSearchView];
}

-(void)addHistoryView{
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 50)/3, 30);
    self.flowLayout.minimumLineSpacing = 15;
    self.flowLayout.minimumInteritemSpacing = 15;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.historyCollect registerNib:[UINib nibWithNibName:@"HomeSearchHistoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSearchHistoryCollectionViewCell"];
    self.historyBgview.hidden = YES;
}

-(void)addSearchView{
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.delegate = self;
    
    // 创建collectionView
    self.searhCollect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, statusHeight + 70, ksrcwidth, ksrcheight - statusHeight - 70) collectionViewLayout:waterFallLayout];
    self.searhCollect.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    self.searhCollect.dataSource = self;
    self.searhCollect.delegate = self;
    self.searhCollect.tag = 10;
    [self.view addSubview:self.searhCollect];
    // 注册
    [self.searhCollect registerNib:[UINib nibWithNibName:@"HomePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionViewCell"];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.historyCollect) {
        HomeSearchHistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSearchHistoryCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
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
