//
//  MessageSetVC.m
//  ScmProject
//
//  Created by leosun on 2020/11/25.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageSetVC.h"

@interface MessageSetVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UISwitch *thumBtn;
@property (weak, nonatomic) IBOutlet UISwitch *commandBtn;
@property (weak, nonatomic) IBOutlet UISwitch *flowBtn;
@property (assign, nonatomic) long thum;
@property (assign, nonatomic) long command;
@property (assign, nonatomic) long flow;

@end

@implementation MessageSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightConst.constant = navBarHeight;
    [self getData];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)thumClick:(id)sender {
    self.thum = self.thum == 0?1:0;
    [self setInfoMsg];
}

- (IBAction)commandClick:(id)sender {
    self.command = self.command == 0?1:0;
    [self setInfoMsg];
}

- (IBAction)flowClick:(id)sender {
    self.flow = self.flow == 0?1:0;
    [self setInfoMsg];
}

-(void)getData{
    NSDictionary *dict = @{@"userId": [Manager takeoutUserTokenkey:Loginuser].userId};
    WeakSelf(self);
    [WebServices postWithUrl:@"news/newssetting/" body:dict loadingTime:12.f showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            weakself.thumBtn.on = weakself.thum = [result[resultData][@"isLike"] longLongValue] == 1;
            weakself.commandBtn.on = weakself.command = [result[resultData][@"isAppraise"] longLongValue] == 1;
            weakself.flowBtn.on = weakself.flow = [result[resultData][@"isFans"] longLongValue] == 1;
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(void)setInfoMsg{
    NSDictionary *dict = @{
        @"isAppraise": [NSString stringWithFormat:@"%ld",self.command],
        @"isFans": [NSString stringWithFormat:@"%ld",self.flow],
        @"isLike": [NSString stringWithFormat:@"%ld",self.thum],
        @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"news/newssetting/" body:dict loadingTime:12.f showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            weakself.thumBtn.on = weakself.thum = [result[resultData][@"isLike"] longLongValue] == 1;
            weakself.commandBtn.on = weakself.command = [result[resultData][@"isAppraise"] longLongValue] == 1;
            weakself.flowBtn.on = weakself.flow = [result[resultData][@"isFans"] longLongValue] == 1;
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}
@end
