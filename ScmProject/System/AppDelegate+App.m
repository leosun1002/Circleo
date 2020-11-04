//
//  AppDelegate+App.m
//  ScmProject
//
//  Created by zhoudong on 2018/7/7.
//  Copyright © 2018年 session. All rights reserved.
//

#import "AppDelegate+App.h"
#import "YYFPSLabel.h"
#import <Bugly/Bugly.h>
#import <AlipaySDK/AlipaySDK.h>
#import "GDLocalizableController.h"
#import <NIMSDK/NIMSDKConfig.h>

@implementation AppDelegate (App)
-(void)changeStatusBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)registeredRouterClass{}


-(void)registerWxPay{
   // [WXApi registerApp:WXAPPKEY];
    [WXApi registerApp:WXAPPKEY universalLink:@"https://jie1.top/#/"];
}

-(void)registerdUMCommon{
    [UMConfigure initWithAppkey:UMConShareKEY channel:nil];
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession|UMSocialPlatformType_WechatTimeLine appKey:WXAPPKEY appSecret:WXAPPSECRET redirectURL:nil];
}

-(void)alipayFun:(NSURL *)url{
    WeakSelf(self);
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            //支付成功通知
            [weakself sendNotification:zfbPaySuccessful dataFun:nil];
        }
        else if([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
            [weakself showMsg:NSLocalizedString(@"取消支付", nil) location:centre];
        }
        else{
            [weakself showMsg:NSLocalizedString(@"支付失败", nil) location:centre];
        }
    }];
}

-(BOOL)wxpayFun:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

//微信支付回调
-(void)onResp:(BaseResp*)resp{
    if(resp == nil) return;
    switch (resp.errCode) {
        case WXSuccess: {
            //支付成功通知
            [self sendNotification:wxPaySuccessful dataFun:nil];
            [self showMsg:NSLocalizedString(@"支付成功", nil) location:centre];
            break;
        }
        case WXErrCodeUserCancel: {
            [self showMsg:NSLocalizedString(@"取消支付", nil) location:centre];
            break;
        }
        default: {
            [self showMsg:NSLocalizedString(@"支付失败", nil) location:centre];
            break;
        }
    }
}

-(void)internationLanguage{
    [GDLocalizableController initUserLanguage];
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSLog(@"%lu",(unsigned long)arr.count);
}

-(void)selectFPS{
    WeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] init];
        fpsLabel.x = weakself.window.width - fpsLabel.width - 20;
        fpsLabel.y = 44;
        [weakself.window addSubview:fpsLabel];
        [weakself.window bringSubviewToFront:fpsLabel];//这句代码会把fpsLabel放到self.window的最顶层.
    });
}

// 普通的获取UUID的方法
- (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}

-(NSString *)getNowDay{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:date];
}

-(void)setFontAndColor{
    NSString *font = [Manager takeoutTokenkey:JYArticleFont];
    NSString *color = [Manager takeoutTokenkey:JYArticleColor];
    if ([AssectString(font) isEqualToString:@""]) {
        [Manager saveToken:@"1" key:JYArticleFont];
    }
    if ([AssectString(color) isEqualToString:@""]) {
        [Manager saveToken:@"0" key:JYArticleColor];
    }
}

-(void)setUpNimSDK{
    //配置额外配置信息 （需要在注册 appkey 前完成
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
    [[NIMSDKConfig sharedConfig] setShouldConsiderRevokedMessageUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setEnabledHttpsForInfo:YES];
    [[NIMSDKConfig sharedConfig] setEnabledHttpsForMessage:YES];
    
    //注册信息
    [[NIMSDK sharedSDK] registerWithOption:[NIMSDKOption optionWithAppKey:NIMSDKKEY]];
    
    [self registerIn];
}

-(void)registerIn{
//    NSDictionary *dict = @{@"username":@"s111",@"password":@"6a9961bb76128524112964c950e973c9",@"nickname":@"1111"};
//    [WebServices postFormReqUrl:@"https://app.netease.im/api/createDemoUser" param:dict loadingTime:12.f callbackBlock:^(id result, NSInteger startCode, NSString *error) {
//        NSLog(@"asd");
//    }];
    NSString *account = @"s1111111111111111111";
    NSString *psw = @"fdd9afcfbb8e5361022720f2f4710436";
    [[[NIMSDK sharedSDK] loginManager] login:account
         token:psw
    completion:^(NSError *error) {
        NSLog(@"asd");
    }];
}
@end
