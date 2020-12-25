//
//  FindClassifyVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "FindClassifyVC.h"
#import "FindClassifyTableViewCell.h"
#import "FindSecondClassifyVC.h"

@interface FindClassifyVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FindClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"FindClassifyTableViewCell" bundle:nil] forCellReuseIdentifier:@"FindClassifyTableViewCell"];
    [self addRefresh];
    [self getData];
    self.titleLabel.text = AssectString(self.category.name);
}

-(void)addRefresh{
    WeakSelf(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData];
    }];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindClassifyTableViewCell"];
    HomeFindCategorysModel *model = self.datas[indexPath.row];
    cell.nameLabel.text = AssectString(model.name);
    [cell.headV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.link)]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindSecondClassifyVC *secondVC = [[FindSecondClassifyVC alloc] init];
    HomeFindCategorysModel *model = self.datas[indexPath.row];
    secondVC.model = model;
    [self.navigationController pushViewController:secondVC animated:YES];
}

-(void)getData{
    WeakSelf(self);
    NSDictionary *dict = @{@"id": AssectString(self.category.categoryId)};
    [WebServices postWithUrl:@"post/homeupfindsoncategory/" body:dict loadingTime:15. showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            NSMutableArray<HomeFindCategorysModel*> *applicationList = [HomeFindCategorysModel mj_objectArrayWithKeyValuesArray:result[resultData]];
            weakself.datas = applicationList;
            [weakself.tableview reloadData];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
    [self.tableview.mj_header endRefreshing];
}

#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
