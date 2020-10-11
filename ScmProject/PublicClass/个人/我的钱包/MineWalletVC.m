//
//  MineWalletVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWalletVC.h"

@interface MineWalletVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineWalletVC

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
