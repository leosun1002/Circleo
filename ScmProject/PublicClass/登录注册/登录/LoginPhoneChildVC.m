//
//  LoginChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/28.
//  Copyright © 2020 session. All rights reserved.
//

#import "LoginPhoneChildVC.h"

@interface LoginPhoneChildVC ()

@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *pswBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

@implementation LoginPhoneChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    WeakSelf(self);
    [[self.phoneText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself checkBtnEnable];
    }];
    [[self.pswText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself checkBtnEnable];
    }];
}

-(void)checkBtnEnable{
    NSString *phone = AssectString(self.phoneText.text);
    NSString *password = AssectString(self.pswText.text);
    if (![phone isEqualToString:@""] && ![password isEqualToString:@""]) {
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#333333"];
        self.checkBtn.userInteractionEnabled = YES;
    }else{
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#C0C0CC"];
        self.checkBtn.userInteractionEnabled = NO;
    }
}

- (IBAction)regiserClick:(id)sender {
    [self.subject sendNext:@"10"];
}

- (IBAction)codeClick:(id)sender {
    [self.subject sendNext:@"11"];
}

- (IBAction)forgetClick:(id)sender {
    [self.subject sendNext:@"13"];
}

- (IBAction)loginClick:(id)sender {
    NSString *phone = AssectString(self.phoneText.text);
    NSString *psw = AssectString(self.pswText.text);
    NSDictionary *dict = @{
          @"code": @"",
          @"loginName": phone,
          @"pwd": [psw md532BitLower]
        };
    
    WeakSelf(self);
    [WebServices postWithUrl:@"user/loginphonepwd/" body:dict loadingTime:15 showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            UserModel *model = [UserModel mj_objectWithKeyValues:result[resultData]];
            [Manager saveUserInfo:model];
            [weakself loginin];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

- (IBAction)pswClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.pswText.secureTextEntry = !sender.selected;
}

@end
