//
//  MineOrderUseVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderUseVC.h"

@interface MineOrderUseVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIView *qrBgView;

@end

@implementation MineOrderUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.qrBgView.layer.borderColor = [UIColor colorWithRGBHex:@"#CACACA"].CGColor;
    self.qrBgView.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}

@end
