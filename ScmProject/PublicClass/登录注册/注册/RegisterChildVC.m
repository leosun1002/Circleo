//
//  RegisterChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/28.
//  Copyright © 2020 session. All rights reserved.
//

#import "RegisterChildVC.h"
#import "FillInformationVC.h"
@interface RegisterChildVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UITextField *retryText;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConst;

@end

@implementation RegisterChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    [self prepareUi];
}

-(void)prepareUi{
    WeakSelf(self);
    [[self.phoneText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself checkBtnEnable];
    }];
    [[self.codeText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself checkBtnEnable];
    }];
    [[self.pswText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself checkBtnEnable];
    }];
    [[self.retryText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself checkBtnEnable];
    }];
    self.titleLabel.text = self.type == 0?NSLocalizedString(@"手机号", nil):NSLocalizedString(@"邮箱", nil);
    self.areaView.hidden = self.type != 0;
    self.widthConst.constant = self.type == 0?60:0;
    self.phoneText.placeholder = self.type == 0?NSLocalizedString(@"请输入手机号码", nil):NSLocalizedString(@"请输入邮箱", nil);
}

-(void)checkBtnEnable{
    NSString *phone = AssectString(self.phoneText.text);
    NSString *code = AssectString(self.codeText.text);
    NSString *password = AssectString(self.pswText.text);
    NSString *retryPsw = AssectString(self.retryText.text);
    if (![phone isEqualToString:@""] && ![code isEqualToString:@""] && ![password isEqualToString:@""] && ![retryPsw isEqualToString:@""]) {
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#333333"];
        self.checkBtn.userInteractionEnabled = YES;
    }else{
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#C0C0CC"];
        self.checkBtn.userInteractionEnabled = NO;
    }
}

- (IBAction)codeClick:(id)sender {
    NSString *phone = AssectString(self.phoneText.text);
    if ([phone isEqualToString:@""]) {
        [self showMsg:self.type == 0?NSLocalizedString(@"请输入手机号", nil):NSLocalizedString(@"请输入邮箱", nil) location:centre];
        return;
    }
    NSDictionary *dict = self.type == 0?@{@"phone":phone}:@{@"email":phone};
    WeakSelf(self);
    [WebServices postWithUrl:self.type == 0?@"user/getVerifyCode/":@"user/getVerifyCodeEmail/" body:dict loadingTime:15.f showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            [weakself openCountdown];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

- (void)openCountdown{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,DISPATCH_TIME_NOW,1.0*NSEC_PER_SEC, 0); //每秒执行
    WeakSelf(self);
    dispatch_source_set_event_handler(timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [weakself.codeBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
                weakself.codeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.codeBtn setTitle:[NSString stringWithFormat:@"%ds",seconds] forState:UIControlStateNormal];
                weakself.codeBtn.userInteractionEnabled = YES;
            });
            time--;
        }
    });
    dispatch_resume(timer);
}

- (IBAction)checkClick:(id)sender {
    NSString *phone = AssectString(self.phoneText.text);
    NSString *code = AssectString(self.codeText.text);
    NSString *psw = AssectString(self.pswText.text);
    NSString *retryPsw = AssectString(self.retryText.text);
    if (![psw isEqualToString:retryPsw]) {
        [self showMsg:NSLocalizedString(@"两次输入密码不一致", nil) location:centre];
        return;
    }
    NSDictionary *dict = @{
          @"code": code,
          (self.type == 0?@"phone":@"email"): phone,
          @"pwd": [psw md532BitLower]
        };
    
    WeakSelf(self);
    [WebServices postWithUrl:self.type == 0?@"user/registerphone/":@"user/registeremail/" body:dict loadingTime:15 showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            UserModel *model = [UserModel mj_objectWithKeyValues:result[resultData]];
            [Manager saveUserInfo:model];
            [weakself gotoFill];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(void)gotoFill{
    FillInformationVC *fillVC = [[FillInformationVC alloc] init];
    fillVC.fillType = FillInformationLogin;
    [self.navigationController pushViewController:fillVC animated:YES];

}
@end
