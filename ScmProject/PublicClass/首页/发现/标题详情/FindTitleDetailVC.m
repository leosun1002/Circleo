
//
//  FindTitleDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/11/20.
//  Copyright © 2020 session. All rights reserved.
//

#import "FindTitleDetailVC.h"

@interface FindTitleDetailVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FindTitleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightConst.constant = navBarHeight;
    self.titleLabel.text = self.titleStr;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
