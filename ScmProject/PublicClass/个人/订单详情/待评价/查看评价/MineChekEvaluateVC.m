//
//  MineChekEvaluateVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineChekEvaluateVC.h"
#import "MerchantDetailEvaluateTableViewCell.h"

@interface MineChekEvaluateVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineChekEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantDetailEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantDetailEvaluateTableViewCell"];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantDetailEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantDetailEvaluateTableViewCell"];
    return cell;
}

@end
