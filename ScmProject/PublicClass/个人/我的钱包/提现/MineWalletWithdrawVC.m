//
//  MineWalletWithdrawVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/12.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWalletWithdrawVC.h"
#import "MineWithdrawRecordVC.h"

@interface MineWalletWithdrawVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

@implementation MineWalletWithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.moneyText.placeholder attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:@"#C0C0C0"],
                 NSFontAttributeName:[UIFont systemFontOfSize:14]
         }];
    self.moneyText.attributedPlaceholder = attrString;
    
    WeakSelf(self);
    [[self.moneyText rac_signalForControlEvents:(UIControlEventEditingChanged)]  subscribeNext:^(id x) {
        weakself.checkBtn.userInteractionEnabled = ![AssectString( weakself.moneyText.text) isEqualToString:@""];
        weakself.checkBtn.backgroundColor = ![AssectString( weakself.moneyText.text) isEqualToString:@""]?[UIColor colorWithRGBHex:@"#333333"]:[UIColor colorWithRGBHex:@"##C0C0CC"];
    }];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)recordClick:(id)sender {
    MineWithdrawRecordVC *record = [[MineWithdrawRecordVC alloc] init];
    [self.navigationController pushViewController:record animated:YES];
}

@end
