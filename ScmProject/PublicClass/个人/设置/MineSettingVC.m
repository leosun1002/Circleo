//
//  MineSettingVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineSettingVC.h"
#import "MineSetPhoneMailVC.h"
#import "MineChangePswVC.h"
#import "MineChangePayPswVC.h"
#import "MineFeedBackVC.h"
#import "FindTitleDetailVC.h"
#import <SDImageCache.h>

@interface MineSettingVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation MineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    self.cacheLabel.text = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
}

- (IBAction)emailClick:(id)sender {
    MineSetPhoneMailVC *mail = [[MineSetPhoneMailVC alloc] init];
    mail.phoneMail = @"邮箱";
    [self.navigationController pushViewController:mail animated:YES];
}

- (IBAction)phoneClick:(id)sender {
    MineSetPhoneMailVC *mail = [[MineSetPhoneMailVC alloc] init];
    mail.phoneMail = @"手机号";
    [self.navigationController pushViewController:mail animated:YES];
}

- (IBAction)pswClick:(id)sender {
    MineChangePswVC *psw = [[MineChangePswVC alloc] init];
    [self.navigationController pushViewController:psw animated:YES];
}

- (IBAction)paypswClick:(id)sender {
    MineChangePayPswVC *paypsw = [[MineChangePayPswVC alloc] init];
    [self.navigationController pushViewController:paypsw animated:YES];
}

- (IBAction)feedBackClick:(id)sender {
    MineFeedBackVC *feedBack = [[MineFeedBackVC alloc] init];
    [self.navigationController pushViewController:feedBack animated:YES];
}

- (IBAction)xieyiClick:(id)sender {
    FindTitleDetailVC *detail = [[FindTitleDetailVC alloc] init];
    detail.titleStr = NSLocalizedString(@"用户协议和隐私政策", nil);
    [self.navigationController pushViewController:detail animated:YES];
}

- (IBAction)aboutClick:(id)sender {
    FindTitleDetailVC *detail = [[FindTitleDetailVC alloc] init];
    detail.titleStr = NSLocalizedString(@"关于我们", nil);
    [self.navigationController pushViewController:detail animated:YES];
}

- (IBAction)clearCacheClick:(id)sender {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{}];
    [self showMsg:NSLocalizedString(@"清理完成",nil) location:centre];
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    self.cacheLabel.text = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
}


@end
