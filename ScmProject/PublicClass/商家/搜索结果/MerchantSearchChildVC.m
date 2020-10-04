//
//  MerchantSearchChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantSearchChildVC.h"
#import "MerchantHomeTableViewCell.h"

@interface MerchantSearchChildVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MerchantSearchChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantHomeTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantHomeTableViewCell"];
    return cell;
}
@end
