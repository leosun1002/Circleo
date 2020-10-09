//
//  MerchantOrderVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/7.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantOrderVC.h"
#import "MerchantOrderTableViewCell.h"
#import "MerchantOrderHeader.h"
#import "MerchantOrderFooter.h"
#import "MerchantPayWayVC.h"

@interface MerchantOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MerchantOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantOrderTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 54;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MerchantOrderHeader *header = [[MerchantOrderHeader alloc] init];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 145;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MerchantOrderFooter *footer = [[MerchantOrderFooter alloc] init];
    return footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantOrderTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantPayWayVC *payWay = [[MerchantPayWayVC alloc] init];
    [self.navigationController pushViewController:payWay animated:YES];
}
@end
