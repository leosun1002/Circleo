//
//  Manager.h
//  Millect
//
//  Created by 叶中刚 on 2017/3/27.
//  Copyright © 2017年 yunzhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

+ (void)saveToken:(NSString* )token key:(NSString* )key;
+(BOOL)hasAvalibleTokenkey:(NSString* )key;
+ (void)clearTokenkey:(NSString* )key;
+(NSString* )takeoutTokenkey:(NSString* )key;

//中心化用户存储
+(void)saveUserToken:(NSDictionary* )userDic key:(NSString* )key;
+(BOOL)hasUserAvalibleTokenkey:(NSString* )key;
+ (BOOL)clearUserTokenkey:(NSString* )key;
+(NSDictionary* )takeoutUserTokenkey:(NSString* )key;

+(void)saveUserArrays:(NSArray *)arrays key:(NSString* )key;
+(NSArray *)takeUserArrays:(NSString* )key;

+(void)saveUserInfo:(NSDictionary *)dict;

@end
