//
//  MineRefundDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineRefundDetailVC.h"

@interface MineRefundDetailVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@property (strong, nonatomic) IBOutlet UIView *sucView;
@property (strong, nonatomic) IBOutlet UIView *failView;
@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgHeightConst;

@end

@implementation MineRefundDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightConst.constant = navBarHeight;
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.waitView.frame = CGRectMake(0, 0, ksrcwidth - 20, 176);
    [self.bgView addSubview:self.waitView];
    self.bgHeightConst.constant = 176;
}

@end
