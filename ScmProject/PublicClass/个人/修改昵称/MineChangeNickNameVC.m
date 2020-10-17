//
//  MineChangeNickNameVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineChangeNickNameVC.h"

@interface MineChangeNickNameVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineChangeNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
}
@end
