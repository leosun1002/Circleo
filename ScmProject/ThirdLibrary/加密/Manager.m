//
//  Manager.m
//  Millect
//
//  Created by 叶中刚 on 2017/3/27.
//  Copyright © 2017年 yunzhuan. All rights reserved.
//

#import "Manager.h"

NSString* const TOKEN_KEY = @"token";
NSString* const DATE_KEY = @"date";

@implementation Manager

//保存token 传入 token   传入  时间
+ (void)saveToken:(NSString* )token key:(NSString* )key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:key];
    [userDefaults synchronize];
}

//判断是否有token
+(BOOL)hasAvalibleTokenkey:(NSString* )key{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token = [userDefaults objectForKey:key];
    if (token) {
        return YES;
    }else{
        return NO;}
}


//删除token
+ (void)clearTokenkey:(NSString* )key{
    NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

//取出
+(NSString* )takeoutTokenkey:(NSString* )key{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString*  token = [userDefaults objectForKey:key];
    return token;
}

+(void)saveUserToken:(NSDictionary* )userDic key:(NSString* )key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userDic forKey:key];
    [userDefaults synchronize];
}

+(BOOL)hasUserAvalibleTokenkey:(NSString* )key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* token = [userDefaults objectForKey:key];
    if(token!=nil)
    
        return YES;
    else
        return NO;
}

+ (BOOL)clearUserTokenkey:(NSString* )key{
    NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
     return [userDefaults synchronize];
}

+(UserModel* )takeoutUserTokenkey:(NSString* )key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *token = [userDefaults objectForKey:key];
    UserModel *model = [UserModel mj_objectWithKeyValues:token];
    return model;
}

+(void)saveUserArrays:(NSArray *)arrays key:(NSString *)key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:arrays forKey:key];
    [userDefaults synchronize];
}

+(NSArray *)takeUserArrays:(NSString *)key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *userArrays = [userDefaults objectForKey:key];
    return userArrays;
}

+(void)saveUserInfo:(UserModel *)model{
    UserModel *oldModel = [Manager takeoutUserTokenkey:Loginuser];
    NSMutableDictionary *oldDict = [oldModel.mj_keyValues mutableCopy];
    NSDictionary *newDict = model.mj_keyValues;
    if (oldDict == nil) {
        [Manager saveUserToken:newDict key:Loginuser];
        return;
    }
    
    for (NSString *key in oldDict.allKeys) {
        if (![AssectString(newDict[key]) isEqualToString:@""]) {
            [oldDict setValue:AssectString(newDict[key]) forKey:key];
        }
    }
    [Manager saveUserToken:[oldDict copy] key:Loginuser];
}

@end
