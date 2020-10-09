//
//  MerchantPayWayVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantPayWayVC.h"
#import "MerchantPayDoneVC.h"

@interface MerchantPayWayVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (strong, nonatomic) NSArray *btns;

@end

@implementation MerchantPayWayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    UIButton *btn1 = [self.view viewWithTag:10];
    UIButton *btn2 = [self.view viewWithTag:11];
    UIButton *btn3 = [self.view viewWithTag:12];
    UIButton *btn4 = [self.view viewWithTag:13];
    UIButton *btn5 = [self.view viewWithTag:14];
    self.btns = @[btn1,btn2,btn3,btn4,btn5];
}

- (IBAction)selectClick:(UIButton *)sender {
    for (UIButton *btn in self.btns) {
        btn.selected = NO;
    }
    sender.selected = YES;
//    MerchantPayDoneVC *payDone = [[MerchantPayDoneVC alloc] init];
//    [self.navigationController pushViewController:payDone animated:YES];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
