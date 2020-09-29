//
//  DES3EncryptUtil.h
//  ZhongDing
//
//  Created by 叶中刚 on 16/5/20.
//  Copyright © 2016年 zhongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3EncryptUtil : NSObject

//加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

//base64编码
+ (NSString*)base64encode:(NSString*)str;

// base64解码
+ (NSString*)base64Decode:(NSString*)str;
@end
