//
//  NSObject+Objdect.h
//  ScmProject
//
//  Created by zhoudong on 2018/7/10.
//  Copyright © 2018年 session. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ToastBlock)(void);

@interface NSObject (Objdect)

typedef NS_ENUM(NSUInteger, LocaType) {
   
    top = 1,
    centre = 2,
    bottom = 3
};

//pop显示消息
-(void)showMsg:(NSString*)msg location:(LocaType)loca;

//pop显示消息回调
-(void)showMsg:(NSString*)msg withBlcok:(ToastBlock)block;

//发通知
-(void)sendNotification:(NSString*)notName dataFun:(id)data;
//删除通知
-(void)deleteNotification:(NSString*)notName observer:(id)obj;

//显示等待菊花
-(void)showLoading:(NSString*)msg  allowsOpOperation:(BOOL)allows;

//消失等待菊花
-(void)dismissLoading;

//手机唯一标识
-(NSString*)getUUidFun;

-(NSString*)getBundleID;

//json 字典相互转化
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
-(NSString *)convertToJsonData:(NSDictionary *)dict;

- (NSString *)removeSpaceAndNewline:(NSString *)str;

+ (NSString*) judgePasswordStrength:(NSString*) _password;

- (NSString*) replacePhoneWithStar:(NSString *)phone;

-(void)popToNav:(UINavigationController* )nav withPopVC:(NSString* )vcStr;

//网络异常
-(void)showErrorView:(UIView *)view withBlock:(ToastBlock)block;

//登录
-(void)loginin;
-(void)getUserRootVC;
-(void)loginout;
-(void)getUserLoginVC;

@end
