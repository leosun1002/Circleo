//
//  MineMyAppointChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineMyAppointChildVC.h"
#import "MineMyAppointTableViewCell.h"
#import "MineApppointDetailVC.h"
#import "MyAppointModel.h"

@interface MineMyAppointChildVC ()<UITableViewDelegate,UITableViewDataSource>{
    int page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, assign) BOOL hasRefresh;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation MineMyAppointChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preapreUi];
    [self addRefresh];
}

-(void)preapreUi{
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineMyAppointTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineMyAppointTableViewCell"];
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
    NSDictionary *dict = @{
        @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
        @"status": [NSString stringWithFormat:@"%ld",self.type],
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"my/mymeet/" body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            ifFresh?[weakself.datas removeAllObjects]:nil;
            NSMutableArray<MyAppointModel *> *applicationList = [MyAppointModel mj_objectArrayWithKeyValuesArray:result[resultData]];
            [weakself.datas addObjectsFromArray:applicationList];
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
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMyAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMyAppointTableViewCell"];
    cell.model = self.datas[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineApppointDetailVC *detail = [[MineApppointDetailVC alloc] init];
    MyAppointModel *model = self.datas[indexPath.row];
    detail.appointId = model.appointId;
    [self.navigation pushViewController:detail animated:YES];
}

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
