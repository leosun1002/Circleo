//
//  DES3EncryptUtil.m
//  ZhongDing
//
//  Created by 叶中刚 on 16/5/20.
//  Copyright © 2016年 zhongyin. All rights reserved.
//

#import "DES3EncryptUtil.h"
#import <CommonCrypto/CommonCryptor.h>


#define gkey @"jieyi"

#define gIv @"jieyi"


#import "MyBase64.h"
@implementation DES3EncryptUtil


// 加密方法
+ (NSString*)encrypt:(NSString*)plainText {
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [MyBase64 base64EncodedStringFrom:myData];
    return result;
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText {
    NSData *encryptData = [MyBase64 dataWithBase64EncodedString:encryptText];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    return result;
}


+ (NSString*)base64encode:(NSString*)str {
    // 1.把字符串转成二进制数据
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 2.将二进制进行base64加密(编码)
    // iOS7以后才有的方法
    return [data base64EncodedStringWithOptions:0];
}

// base64解码
+ (NSString*)base64Decode:(NSString*)str {
    // 1.先把base64编码后的字符串转成二进制数据
    NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    // 2.把data转成字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end

