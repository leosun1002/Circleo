//
//  Contant.h
//  ScmProject
//
//  Created by zhoudong on 2018/7/7.
//  Copyright © 2018年 session. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Contant <NSObject>

#define PI 3.14
//加快审核
#define AppVersion @"1.6.2"

    //屏幕高宽
#define ksrcwidth [UIScreen mainScreen].bounds.size.width
#define ksrcheight [UIScreen mainScreen].bounds.size.height

//ipx
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhone6     ([[UIScreen mainScreen] bounds].size.height == 667)
#define iPhone6Plus ([[UIScreen mainScreen] bounds].size.height == 736)
#define IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define IS_IPHONEX (IS_IOS_11 && IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))
#define navBarHeight ((IS_IPHONEX == YES)? 88.0f:64.0f)
#define tabbarHeight ((IS_IPHONEX == YES) ? (49.f+34.f) : 49.f)
#define bottomY ((IS_IPHONEX == YES)?30.0f:0.0f)
#define statusHeight ((IS_IPHONEX == YES)? 44.0f:20.0f)

    //系统版本
#define IOSVer [[[UIDevice currentDevice] systemVersion]floatValue]
   
    //app的版本号
//#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
    
    //app build版本号
#define kAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
    
    //weak self
#define WeakSelf(type) __weak typeof(type) weak##type = type

//String
#define AssectString(param) [(param) isKindOfClass:[NSNumber class]] ? [((NSNumber *)param) stringValue] : ([(param) isKindOfClass:[NSString class]] ? ([[(param) lowercaseString] isEqualToString:@"null"] ? @"" : (param)): @"")
#define AssectNumber(param) !(param) || [(param) isEqualToString:@""]?@"0":(param)
//英文和数字
#define ENGALPHAN  @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define NUMBERALPHAN  @"1234567890"

#define CHINESE @"zh-Hans"
#define ENGLISH @"en"

#define access_token @"access_token"//用户token
#define UserId @"UserId"//用户token

#define history_Arrays @"history_Arrays"//记录

#define UpdateDay @"UpdateDay"//记录


//用户信息
#define Loginuser @"Loginuser"


@end
