//
//  MineChangeNickNameVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineChangeNickNameVC.h"

@interface MineChangeNickNameVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;

@end

@implementation MineChangeNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"修改%@", nil),self.titleStr];
    self.text.placeholder = [NSString stringWithFormat:NSLocalizedString(@"请输入%@", nil),self.titleStr];
    self.maxLabel.hidden = [AssectString(self.titleStr) isEqualToString:@"邮编"];
}

#pragma -mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.checkBtn.userInteractionEnabled = toBeString.length > 0;
    self.checkBtn.backgroundColor = toBeString.length > 0 ? [UIColor colorWithRGBHex:@"#333333"]:[UIColor colorWithRGBHex:@"#C0C0CC"];
    if ([AssectString(self.titleStr) isEqualToString:@"邮编"]) {
        return YES;
    }
    if ([toBeString length] > 8) {
        textField.text = [toBeString substringToIndex:8];
        return NO;
    }
    return YES;
}
@end
