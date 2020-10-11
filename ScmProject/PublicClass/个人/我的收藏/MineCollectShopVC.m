//
//  MineCollectShopVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineCollectShopVC.h"
#import "MerchantHomeTableViewCell.h"

@interface MineCollectShopVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MineCollectShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantHomeTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

#pragma -mark
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
@end
