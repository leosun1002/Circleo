//
//  MineMyAppointChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineMyAppointChildVC.h"
#import "MineMyAppointTableViewCell.h"
#import "MineApppointDetailVC.h"

@interface MineMyAppointChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MineMyAppointChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preapreUi];
}

-(void)preapreUi{
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineMyAppointTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineMyAppointTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMyAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMyAppointTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineApppointDetailVC *detail = [[MineApppointDetailVC alloc] init];
    [self.navigation pushViewController:detail animated:YES];
}
@end
