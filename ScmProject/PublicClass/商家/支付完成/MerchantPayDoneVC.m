//
//  MerchantPayDoneVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantPayDoneVC.h"

@interface MerchantPayDoneVC ()

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

@implementation MerchantPayDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.checkBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.checkBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
