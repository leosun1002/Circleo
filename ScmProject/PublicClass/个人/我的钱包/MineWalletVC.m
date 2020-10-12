//
//  MineWalletVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWalletVC.h"
#import "MineWalletDetailVC.h"
#import "MineWalletChargeVC.h"

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

- (IBAction)detaiClick:(id)sender {
    MineWalletDetailVC *detail = [[MineWalletDetailVC alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (IBAction)chargeClick:(id)sender {
    MineWalletChargeVC *charge = [[MineWalletChargeVC alloc] init];
    [self.navigationController pushViewController:charge animated:YES];
}

@end
