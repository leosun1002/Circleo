//
//  MineSetPhoneMailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineSetPhoneMailVC.h"
#import "MineBindPhoneMailVC.h"

@interface MineSetPhoneMailVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCosnt;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation MineSetPhoneMailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)bindClick:(id)sender {
    MineBindPhoneMailVC *bindMail = [[MineBindPhoneMailVC alloc] init];
    bindMail.phoneMail = self.phoneMail;
    [self.navigationController pushViewController:bindMail animated:YES];
}

-(void)prepareUi{
    self.heightCosnt.constant = navBarHeight;
    self.titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"修改%@", nil),self.phoneMail];
    self.tipLabel.text = [self.phoneMail isEqualToString:@"邮箱"]?[NSString stringWithFormat:@"已绑定邮箱：156454****@qq.com"]:[NSString stringWithFormat:@"已绑定手机号：188****0276"];
}
@end
