//
//  MineWithdrawDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/12.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWithdrawDetailVC.h"

@interface MineWithdrawDetailVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;

@end

@implementation MineWithdrawDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preapreUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)preapreUi{
    self.heightConst.constant = navBarHeight;
    self.connectBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.connectBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}

@end
