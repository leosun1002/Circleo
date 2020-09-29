
//
//  AppDelegate+App.h
//  ScmProject
//
//  Created by zhoudong on 2018/7/7.
//  Copyright © 2018年 session. All rights reserved.
//

#import "AppDelegate.h"
#import <WXApi.h>

@interface AppDelegate (App)<WXApiDelegate>
-(void)changeStatusBar;
-(void)registeredRouterClass;
-(void)registerWxPay;
-(void)registerdUMCommon;
-(void)internationLanguage;

-(void)alipayFun:(NSURL *)url;//alipay
-(BOOL)wxpayFun:(NSURL *)url;//alipay

-(void)upVerFun;
-(void)selectFPS;

-(void)setFontAndColor;

@end
