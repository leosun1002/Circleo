//
//  MerchantNearbyView.m
//  ScmProject
//
//  Created by leosun on 2020/10/4.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantNearbyView.h"
#import "MerchantHomeTableViewCell.h"
#import "MerchantShopDetailVC.h"

@interface MerchantNearbyView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *tableview;

@end

@implementation MerchantNearbyView

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
    [self.tableview setFrame:CGRectMake(10, 0, ksrcwidth - 20, self.height)];
}

-(void)prepareUi{
    // 创建collectionView
    UITableView * tableview = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.layer.cornerRadius = 10;
    tableview.layer.masksToBounds = YES;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableview = tableview];
    // 注册
    [tableview registerNib:[UINib nibWithNibName:@"MerchantHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantHomeTableViewCell"];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantHomeTableViewCell"];
    cell.contentView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantShopDetailVC *detail = [[MerchantShopDetailVC alloc] init];
    [self.navigation pushViewController:detail animated:YES];
}

#pragma -mark JXPagerViewListViewDelegate
- (UIScrollView *)listScrollView {
    return self.tableview;
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
