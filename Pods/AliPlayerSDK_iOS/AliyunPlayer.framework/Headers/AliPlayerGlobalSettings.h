//
//  AliPlayerGlobalSettings.h
//  AliPlayerGlobalSettings
//
//  Created by huang_jiafa on 2020/04/09.
//  Copyright © 2020 com.alibaba.AliyunPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVPDef.h"

OBJC_EXPORT
@interface AliPlayerGlobalSettings : NSObject

/**
 @brief 设置域名对应的解析ip
 @param host 域名，需指定端口（http默认端口80，https默认端口443）。例如player.alicdn.com:443
 @param ip 相应的ip，设置为空字符串清空设定。
 */
/****
 @brief Set a DNS ip to resolve the host.
 @param host The host. Need to specify the port (http defualt port is 80，https default port is 443). E.g player.alicdn.com:443
 @param ip The ip address, set as empty string to clear the setting.
 */
+(void)setDNSResolve:(NSString *)host ip:(NSString *)ip;

/**
 @brief 设置解析ip类型
 @param type 解析ip的类型
 */
/****
 @brief Set a IP type when  resolve the host.
 @param type The IP type.
 */
+(void)setIpResolveType:(AVPIpResolveType)type;

@end
