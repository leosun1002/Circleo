//
//  MessageSetVC.m
//  ScmProject
//
//  Created by leosun on 2020/11/25.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageSetVC.h"

@interface MessageSetVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MessageSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightConst.constant = navBarHeight;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
