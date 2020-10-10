//
//  MineOrderWaitPayVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderWaitPayVC.h"

@interface MineOrderWaitPayVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation MineOrderWaitPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.cancelBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.cancelBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}

@end
