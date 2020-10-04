//
//  FansFollowListVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "FansFollowListVC.h"
#import "FansFollowTableViewCell.h"

@interface FansFollowListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation FansFollowListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"FansFollowTableViewCell" bundle:nil] forCellReuseIdentifier:@"FansFollowTableViewCell"];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FansFollowTableViewCell"];
    return cell;
}

@end
