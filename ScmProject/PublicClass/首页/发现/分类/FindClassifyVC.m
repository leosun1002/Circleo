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
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindClassifyTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindSecondClassifyVC *secondVC = [[FindSecondClassifyVC alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
