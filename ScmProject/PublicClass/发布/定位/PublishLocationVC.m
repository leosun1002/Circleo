//
//  PublishLocationVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/22.
//  Copyright © 2020 session. All rights reserved.
//

#import "PublishLocationVC.h"
#import "PublishLocationTableViewCell.h"

@interface PublishLocationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation PublishLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"PublishLocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"PublishLocationTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

#pragma mark -UITableViewDelegate;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, (50 - 15)/2, 12, 15)];
    img.image = [UIImage imageNamed:@"dizhi"];
    [view addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img.frame) + 10, (50 - 15)/2, ksrcwidth - CGRectGetMaxX(img.frame) - 25, 15)];
    label.text = @"不显示位置";
    label.textColor = [UIColor colorWithRGBHex:@"#333333"];
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishLocationTableViewCell"];
    return cell;
}
@end
