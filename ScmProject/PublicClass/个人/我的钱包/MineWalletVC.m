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
#import "MineWalletWithdrawVC.h"
#import "MineWalletBankCardVC.h"

@interface MineWalletVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIView *withdrawView;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIView *creditView;

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
    
    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        MineWalletWithdrawVC *withdraw = [[MineWalletWithdrawVC alloc] init];
        [weakself.navigationController pushViewController:withdraw animated:YES];
    }];
    [self.withdrawView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [[tap1 rac_gestureSignal] subscribeNext:^(id x) {
        MineWalletBankCardVC *card = [[MineWalletBankCardVC alloc] init];
        [weakself.navigationController pushViewController:card animated:YES];
    }];
    [self.cardView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    [[tap2 rac_gestureSignal] subscribeNext:^(id x) {
        MineWalletBankCardVC *card = [[MineWalletBankCardVC alloc] init];
        [weakself.navigationController pushViewController:card animated:YES];
    }];
    [self.creditView addGestureRecognizer:tap2];
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
