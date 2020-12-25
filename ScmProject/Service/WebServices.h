//
//  WebServices.h
//  ScmProject
//
//  Created by zhoudong on 2018/7/7.
//  Copyright © 2018年 session. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RequestCallBackBlock)(id result, NSInteger startCode, NSString *error);

@interface WebServices : NSObject

//Post请求
+(NSURLSessionTask*)postFormReqUrl:(NSString*)url param:(NSDictionary*)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block;

//Get请求
+(NSURLSessionTask*)getFormReqUrl:(NSString*)url param:(NSDictionary*)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block;

//上传图片
+(NSURLSessionTask*)postImageFormReqUrl:(NSString*)url image:(UIImage *)image param:(NSDictionary*)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block;

//批量上传图片
+(NSURLSessionTask*)postImageFormReqUrl:(NSString*)url images:(NSArray *)images param:(NSDictionary*)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block;

//new POST
+ (NSURLSessionTask*)postWithUrl:(NSString *)url body:(NSDictionary *)body loadingTime:(NSInteger)time showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;
@end
