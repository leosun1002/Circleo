//
//  LoginEmailChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/28.
//  Copyright © 2020 session. All rights reserved.
//

#import "LoginEmailChildVC.h"

@interface LoginEmailChildVC ()

@end

@implementation LoginEmailChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)registClick:(id)sender {
    [self.subject sendNext:@"10"];
}

- (IBAction)codeClick:(id)sender {
    [self.subject sendNext:@"11"];
}

- (IBAction)forgetClick:(id)sender {
    [self.subject sendNext:@"12"];
}

- (IBAction)loginClick:(id)sender {
    [self.subject sendNext:@"13"];
}

@end
