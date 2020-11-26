//
//  MineBindPhoneMailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineBindPhoneMailVC.h"

@interface MineBindPhoneMailVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation MineBindPhoneMailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"修改%@", nil),self.phoneMail];
    self.phoneText.placeholder = [self.phoneMail isEqualToString:@"邮箱"]?NSLocalizedString(@"请输入邮箱账号", nil):NSLocalizedString(@"请输入手机号", nil);
}

@end
