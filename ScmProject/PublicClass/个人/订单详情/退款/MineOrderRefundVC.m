//
//  MineOrderRefundVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderRefundVC.h"
#import "MineRefundDetailVC.h"

@interface MineOrderRefundVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineOrderRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)detailClick:(id)sender {
    MineRefundDetailVC *detail = [[MineRefundDetailVC alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
}
@end
