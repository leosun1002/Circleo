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

@interface MineOrderChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MineOrderChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineOrderTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    self.view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];

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
@end
