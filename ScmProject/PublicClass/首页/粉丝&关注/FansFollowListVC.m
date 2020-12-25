//
//  FansFollowListVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "FansFollowListVC.h"
#import "FansFollowTableViewCell.h"
#import "FansModel.h"

@interface FansFollowListVC ()<UITableViewDelegate,UITableViewDataSource>{
    int page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation FansFollowListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    if (![AssectString(self.titleStr) isEqualToString:@""]) {
        self.titleLabel.text = self.titleStr;
    }
    self.heightConst.constant = navBarHeight;
    [self.tableview registerNib:[UINib nibWithNibName:@"FansFollowTableViewCell" bundle:nil] forCellReuseIdentifier:@"FansFollowTableViewCell"];
}

-(void)addRefresh{
    WeakSelf(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getFansData:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getFansData:NO];
    }];
}

-(void)getFansData:(BOOL)ifFresh{
    ifFresh?(page = 1):page++;
    WeakSelf(self);
    NSDictionary *dict = @{
        @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    NSString *url = @"";
    if (self.type == 10) {
        url = @"my/myfans/";
    }else if (self.type == 11){
        url = @"my/myattention/";
    }else{
        url = @"my/myfriend/";
    }
    [WebServices postWithUrl:url body:dict loadingTime:12.f showLoading:NO success:^(NSDictionary *response) {
        ifFresh?[weakself.datas removeAllObjects]:nil;
        NSMutableArray<FansModel *> *applicationList = [FansModel mj_objectArrayWithKeyValuesArray:response[resultData]];
        [weakself.datas addObjectsFromArray:applicationList];
        [weakself.tableview reloadData];
    } failure:^(NSError *error) {
    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FansFollowTableViewCell"];
    return cell;
}

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
