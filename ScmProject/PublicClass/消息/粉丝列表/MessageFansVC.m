//
//  MessageFansVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageFansVC.h"
#import "MessageFansTableViewCell.h"

@interface MessageFansVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MessageFansVC

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
    [self.tableview registerNib:[UINib nibWithNibName:@"MessageFansTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageFansTableViewCell"];
}

#pragma -mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ksrcwidth - 10, 40)];
    label.text = section == 0?NSLocalizedString(@"新增粉丝", nil):NSLocalizedString(@"全部粉丝", nil);
    label.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:15];
    label.textColor = [UIColor colorWithRGBHex:@"#333333"];
    [view addSubview:label];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageFansTableViewCell"];
    return cell;
}
@end
