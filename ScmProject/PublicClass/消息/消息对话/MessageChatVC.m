//
//  MessageChatVC.m
//  ScmProject
//
//  Created by leosun on 2020/11/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageChatVC.h"
#import <UIView+NIM.h>

@interface MessageChatVC ()

@end

@implementation MessageChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    [self setupTableview];
    //设置顶部
    [self topNavView];
}

-(void)topNavView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, navBarHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((ksrcwidth - 300)/2, navBarHeight - 30, 300, 20)];
    titleLabel.text = @"Circle";
    titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    titleLabel.textColor = [UIColor colorWithRGBHex:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(10, titleLabel.nim_centerY - 15, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"back_black"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
}

-(void)setupTableview{
    self.tableView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
