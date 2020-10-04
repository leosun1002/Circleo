//
//  HomeLocationVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeLocationVC.h"
#import "HomeLocationTableViewCell.h"
#import "HomeLocationHeader.h"

@interface HomeLocationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation HomeLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeLocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeLocationTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 210;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeLocationHeader *header = [[HomeLocationHeader alloc] init];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeLocationTableViewCell"];
    return cell;
}

@end
