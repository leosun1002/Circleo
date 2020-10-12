//
//  MineWalletChargeVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWalletChargeVC.h"

@interface MineWalletChargeVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;
@property (weak, nonatomic) IBOutlet UIButton *paypayBtn;
@property (weak, nonatomic) IBOutlet UIButton *creditBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (copy, nonatomic) NSArray *payBtns;

@end

@implementation MineWalletChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.payBtns = @[self.paypayBtn,self.creditBtn,self.wxBtn,self.aliBtn];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.moneyText.placeholder attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:@"#C0C0C0"],
                 NSFontAttributeName:[UIFont systemFontOfSize:14]
         }];
    self.moneyText.attributedPlaceholder = attrString;
}

- (IBAction)payClick:(UIButton *)sender {
    for (UIButton *btn in self.payBtns) {
        btn.selected = NO;
    }
    sender.selected = YES;
}

@end
