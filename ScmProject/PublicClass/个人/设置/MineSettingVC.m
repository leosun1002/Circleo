//
//  MineSettingVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineSettingVC.h"
#import "MineSetPhoneMailVC.h"
#import "MineChangePswVC.h"
#import "MineChangePayPswVC.h"
#import "MineFeedBackVC.h"

@interface MineSettingVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineSettingVC

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

- (IBAction)emailClick:(id)sender {
    MineSetPhoneMailVC *mail = [[MineSetPhoneMailVC alloc] init];
    [self.navigationController pushViewController:mail animated:YES];
}

- (IBAction)phoneClick:(id)sender {
    MineSetPhoneMailVC *mail = [[MineSetPhoneMailVC alloc] init];
    [self.navigationController pushViewController:mail animated:YES];
}

- (IBAction)pswClick:(id)sender {
    MineChangePswVC *psw = [[MineChangePswVC alloc] init];
    [self.navigationController pushViewController:psw animated:YES];
}

- (IBAction)paypswClick:(id)sender {
    MineChangePayPswVC *paypsw = [[MineChangePayPswVC alloc] init];
    [self.navigationController pushViewController:paypsw animated:YES];
}

- (IBAction)feedBackClick:(id)sender {
    MineFeedBackVC *feedBack = [[MineFeedBackVC alloc] init];
    [self.navigationController pushViewController:feedBack animated:YES];
}

@end
