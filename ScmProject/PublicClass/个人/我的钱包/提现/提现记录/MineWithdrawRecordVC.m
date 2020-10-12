//
//  MineWithdrawRecordVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/12.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWithdrawRecordVC.h"
#import "MineWalletDetailTableViewCell.h"
#import "MineWithdrawDetailVC.h"

@interface MineWithdrawRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineWithdrawRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    [self.tableview registerNib:[UINib nibWithNibName:@"MineWalletDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineWalletDetailTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineWalletDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineWalletDetailTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineWithdrawDetailVC *detail = [[MineWithdrawDetailVC alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}
@end

