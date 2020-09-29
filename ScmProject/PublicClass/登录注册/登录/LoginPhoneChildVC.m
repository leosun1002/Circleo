//
//  LoginChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/28.
//  Copyright © 2020 session. All rights reserved.
//

#import "LoginPhoneChildVC.h"

@interface LoginPhoneChildVC ()

@end

@implementation LoginPhoneChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)regiserClick:(id)sender {
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
