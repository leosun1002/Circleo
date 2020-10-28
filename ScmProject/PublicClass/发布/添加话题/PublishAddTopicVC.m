//
//  PublishAddTopicVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/22.
//  Copyright © 2020 session. All rights reserved.
//

#import "PublishAddTopicVC.h"
#import "PublishAddTopicTableViewCell.h"

@interface PublishAddTopicVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation PublishAddTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"PublishAddTopicTableViewCell" bundle:nil] forCellReuseIdentifier:@"PublishAddTopicTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 54.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView new];
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, ksrcwidth - 25, 15)];
    label.text = @"商家";
    label.textColor = [UIColor colorWithRGBHex:@"#333333"];
    label.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:15];
    [view addSubview:label];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishAddTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishAddTopicTableViewCell"];
    return cell;
}
@end
