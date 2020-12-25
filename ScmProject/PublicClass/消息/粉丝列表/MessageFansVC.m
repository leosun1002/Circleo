//
//  MessageFansVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageFansVC.h"
#import "MessageFansTableViewCell.h"
#import "FansModel.h"

@interface MessageFansVC ()<UITableViewDataSource,UITableViewDelegate>{
    int page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (strong, nonatomic) NSMutableArray *newDatas;
@property (strong, nonatomic) NSMutableArray *allDatas;

@end

@implementation MessageFansVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addRefresh];
    [self.tableview.mj_header beginRefreshing];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MessageFansTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageFansTableViewCell"];
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
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    WeakSelf(self);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [weakself getNewFansData:group withFresh:ifFresh];
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务 2
        [weakself getAllFansData:group withFresh:ifFresh];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakself.tableview.mj_header endRefreshing];
        [weakself.tableview.mj_footer endRefreshing];
        [weakself.tableview reloadData];
    });
}

-(void)getNewFansData:(dispatch_group_t)group withFresh:(BOOL)ifFresh{
    ifFresh?(page = 1):page++;
    WeakSelf(self);
    NSDictionary *dict = @{
        @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    [WebServices postWithUrl:@"news/newsfansadded/" body:dict loadingTime:12.f showLoading:NO success:^(NSDictionary *response) {
        ifFresh?[weakself.newDatas removeAllObjects]:nil;
        NSMutableArray<FansModel*> *applicationList = [FansModel mj_objectArrayWithKeyValuesArray:response[resultData]];
        [weakself.newDatas addObjectsFromArray:applicationList];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);

    }];
}

-(void)getAllFansData:(dispatch_group_t)group withFresh:(BOOL)ifFresh{
    ifFresh?(page = 1):page++;
    WeakSelf(self);
    NSDictionary *dict = @{
        @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    [WebServices postWithUrl:@"news/newsfans/" body:dict loadingTime:12.f showLoading:NO success:^(NSDictionary *response) {
        ifFresh?[weakself.allDatas removeAllObjects]:nil;
        NSMutableArray<FansModel*> *applicationList = [FansModel mj_objectArrayWithKeyValuesArray:response[resultData]];
        [weakself.allDatas addObjectsFromArray:applicationList];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

#pragma -mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int section = 0;
    if (self.newDatas.count > 0) section++;
    if (self.allDatas.count > 0) section++;
    return section;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ksrcwidth - 10, 40)];
    if (self.newDatas.count > 0 && self.allDatas.count <= 0) {
        label.text = NSLocalizedString(@"新增粉丝", nil);
    }else if (self.allDatas.count > 0 && self.newDatas.count <= 0){
        label.text = NSLocalizedString(@"全部粉丝", nil);
    }else{
        label.text = section == 0?NSLocalizedString(@"新增粉丝", nil):NSLocalizedString(@"全部粉丝", nil);
    }
    label.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:15];
    label.textColor = [UIColor colorWithRGBHex:@"#333333"];
    [view addSubview:label];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.newDatas.count > 0 && self.allDatas.count <= 0) {
        return self.newDatas.count;
    }else if (self.allDatas.count > 0 && self.newDatas.count <= 0){
        return self.allDatas.count;
    }else if (self.allDatas.count > 0 && self.newDatas.count > 0){
        return section == 0?self.newDatas.count:self.allDatas.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageFansTableViewCell"];
    if (self.newDatas.count > 0 && self.allDatas.count <= 0) {
        cell.model = self.newDatas[indexPath.row];
    }else if (self.allDatas.count > 0 && self.newDatas.count <= 0){
        cell.model = self.allDatas[indexPath.row];
    }else if (self.allDatas.count > 0 && self.newDatas.count > 0){
        cell.model = indexPath.section == 0?self.newDatas[indexPath.row]:self.allDatas[indexPath.row];
    }
    return cell;
}

#pragma -mark getter
-(NSMutableArray *)newDatas{
    if (!_newDatas) {
        _newDatas = [NSMutableArray array];
    }
    return _newDatas;
}

-(NSMutableArray *)allDatas{
    if (!_allDatas) {
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}
@end
