//
//  SignGenerated.h
//  Cloud Pro
//
//  Created by zhoudong on 2018/8/9.
//  Copyright © 2018年 yunzhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignGenerated : NSObject
+(NSDictionary*)signedAfterDic:(NSArray*)array;
+(NSString*)signAfterString:(NSArray*)array;
+(NSDictionary*)signedShopAfterDic:(NSArray*)array;
@end
