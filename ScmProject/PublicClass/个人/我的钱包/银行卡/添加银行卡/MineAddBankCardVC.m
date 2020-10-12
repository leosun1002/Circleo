//
//  MineAddBankCardVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/12.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineAddBankCardVC.h"

@interface MineAddBankCardVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextField *cardText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *pswText;

@end

@implementation MineAddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClicK:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;

    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.cardText.placeholder attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:@"#C0C0C0"],
                 NSFontAttributeName:[UIFont systemFontOfSize:14]
         }];
    self.cardText.attributedPlaceholder = attrString;

    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:self.dateText.placeholder attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:@"#C0C0C0"],
                 NSFontAttributeName:[UIFont systemFontOfSize:14]
         }];
    self.dateText.attributedPlaceholder = attrString1;

    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:self.pswText.placeholder attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:@"#C0C0C0"],
                 NSFontAttributeName:[UIFont systemFontOfSize:14]
         }];
    self.pswText.attributedPlaceholder = attrString2;

}

@end
