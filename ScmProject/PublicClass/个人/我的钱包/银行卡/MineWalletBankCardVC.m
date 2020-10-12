//
//  MineWalletBankCardVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/12.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWalletBankCardVC.h"
#import "MineAddBankCardVC.h"

@interface MineWalletBankCardVC ()
@property (weak, nonatomic) IBOutlet UIView *noCardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@end

@implementation MineWalletBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preapreUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)preapreUi{
    self.heightConst.constant = navBarHeight;
    self.noCardView.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    self.noCardView.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;

    self.changeBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    self.changeBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;

    self.removeBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    self.removeBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    
    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        MineAddBankCardVC *addCard = [[MineAddBankCardVC alloc] init];
        [weakself.navigationController pushViewController:addCard animated:YES];
    }];
    [self.noCardView addGestureRecognizer:tap];
}
@end
