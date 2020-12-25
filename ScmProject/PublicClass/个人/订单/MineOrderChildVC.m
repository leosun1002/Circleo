//
//  MineOrderChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderChildVC.h"
#import "MineOrderTableViewCell.h"
#import "MineOrderRefundVC.h"
#import "MineApplyRefundVC.h"
#import "MineOrderWaitPayVC.h"
#import "MineOrderUseVC.h"
#import "MineOrderEvaluateVC.h"

@interface MineOrderChildVC ()<UITableViewDelegate,UITableViewDataSource>{
    int page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, assign) BOOL hasRefresh;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation MineOrderChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addRefresh];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineOrderTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    self.view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

-(void)addRefresh{
    WeakSelf(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getData:NO];
    }];
}

-(void)refreshData{
    if (!self.hasRefresh) {
        [self.tableview.mj_header beginRefreshing];
        self.hasRefresh = YES;
    }
}

-(void)getData:(BOOL)ifFresh{
    ifFresh?(page = 1):(page ++);
    NSString *status = @"";
    if (self.type == 0) {
        status = @"4";
    }else{
        status = [NSString stringWithFormat:@"%ld",self.type - 1];
    }
    NSDictionary *dict = @{
        @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
        @"status": status,
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"my/myorder/" body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            ifFresh?[weakself.datas removeAllObjects]:nil;
////            NSMutableArray<MyAppointModel *> *applicationList = [MyAppointModel mj_objectArrayWithKeyValuesArray:result[resultData]];
//            [weakself.datas addObjectsFromArray:applicationList];
            [self.tableview reloadData];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOrderTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineOrderRefundVC *refund = [[MineOrderRefundVC alloc] init];
        [self.navigation pushViewController:refund animated:YES];
    }else if (indexPath.row == 1){
        MineApplyRefundVC *apply = [[MineApplyRefundVC alloc] init];
        [self.navigationController pushViewController:apply animated:YES];
    }else if (indexPath.row == 2){
        MineOrderWaitPayVC *wait = [[MineOrderWaitPayVC alloc] init];
        [self.navigationController pushViewController:wait animated:YES];
    }else if (indexPath.row == 3){
        MineOrderUseVC *use = [[MineOrderUseVC alloc] init];
        [self.navigationController pushViewController:use animated:YES];
    }else if (indexPath.row == 4){
        MineOrderEvaluateVC *evaluate = [[MineOrderEvaluateVC alloc] init];
        [self.navigationController pushViewController:evaluate animated:YES];
    }
}

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
