//
//  SignGenerated.m
//  Cloud Pro
//
//  Created by zhoudong on 2018/8/9.
//  Copyright © 2018年 yunzhuan. All rights reserved.
//
 

#import "SignGenerated.h"
#import "NSString+MD5.h"

#define ShopSignKey @"jyky@ccmai.xin"

@implementation SignGenerated


+(NSDictionary*)signedAfterDic:(NSArray*)array{
    if(array == nil || array.count==0)return nil;
    
    NSMutableDictionary* mutableDic = [NSMutableDictionary new];
    NSMutableString* mutableStr = [NSMutableString new];
    
    for(NSDictionary* p in array){
        if(![p isKindOfClass:[NSDictionary class]]) return nil;
        
        for(NSString* key in p){
            [mutableDic setObject:p[key] forKey:key];
            [mutableStr appendString:key];
            [mutableStr appendString:p[key]];
        }
    }
    
    [mutableDic setObject:[self getSign:mutableStr] forKey:@"sign"];
    
    return mutableDic;
}


+(NSString*)signAfterString:(NSArray*)array{
   
    NSMutableString* mutableStr = [NSMutableString new];
    
    for(NSDictionary* p in array){
        if(![p isKindOfClass:[NSDictionary class]]) return nil;
        
        for(NSString* key in p){
           
            [mutableStr appendString:key];
            [mutableStr appendString:p[key]];
        }
    }
    
    return [self getSign:mutableStr];
}
+(NSString*)getSign:(NSString*)data{
    
    NSString* signStr = [NSString stringWithFormat:@"%@%@",data,[signKey md532BitUpper]];
    return [signStr md532BitUpper];
}

+(NSDictionary*)signedShopAfterDic:(NSArray*)array{
    if(array == nil || array.count==0)return nil;
    
    NSMutableDictionary* mutableDic = [NSMutableDictionary new];
    NSMutableString* mutableStr = [NSMutableString new];
    
    for(NSDictionary* p in array){
        if(![p isKindOfClass:[NSDictionary class]]) return nil;
        
        for(NSString* key in p){
            [mutableDic setObject:p[key] forKey:key];
            [mutableStr appendString:key];
            [mutableStr appendString:p[key]];
        }
    }
    
    [mutableDic setObject:[self getShopSign:mutableStr] forKey:@"sign_string"];
    
    return mutableDic;
}

+(NSString*)getShopSign:(NSString*)data{
    
    NSString* signStr = [NSString stringWithFormat:@"%@%@",data,[ShopSignKey md532BitUpper]];
    
    return [signStr md532BitUpper];
}
@end
