//
//  WebServices.m
//  ScmProject
//
//  Created by zhoudong on 2018/7/7.
//  Copyright © 2018年 session. All rights reserved.
//
#import "WebServices.h"

@implementation WebServices
+(NSURLSessionTask*)postFormReqUrl:(NSString*)url param:(NSDictionary*)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block{
    
    return [self path:url formReq:parameters  loadingTime:time callbackBlock:block imageFun:nil];
}

+(NSURLSessionTask *)getFormReqUrl:(NSString *)url param:(NSDictionary *)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block{
    return [self path:url getReq:parameters  loadingTime:time callbackBlock:block];
}

+(NSURLSessionTask *)postImageFormReqUrl:(NSString *)url image:(UIImage *)image param:(NSDictionary *)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block{
    return [self path:url image:image param:parameters loadingTime:time callbackBlock:block];
}

+(NSURLSessionTask *)postImageFormReqUrl:(NSString *)url images:(NSArray *)images param:(NSDictionary *)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block{
    return [self path:url formReq:parameters  loadingTime:time callbackBlock:block imageFun:images];
}

+(NSURLSessionTask*)path:(NSString*)url formReq:(NSDictionary*)body  loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block imageFun:(NSArray*)imagelist{
    
    //设置http head
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager setSecurityPolicy:[self customSecurityPolicy]];
//    [sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    [sessionManager.requestSerializer setValue:[self getUUidFun] forHTTPHeaderField:@"uuid"];
    [sessionManager.requestSerializer setValue:@"0" forHTTPHeaderField:@"versiontype"];
    [sessionManager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"ver"];
    [sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];
    [sessionManager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"phoneOs"];
    [sessionManager.requestSerializer setValue:[[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"en":@"zh-CN" forHTTPHeaderField:@"language"];
    [sessionManager.requestSerializer setValue:PlatformCode forHTTPHeaderField:@"platformCode"];
    NSString *bundVer = [[self getBundleID] isEqualToString:@"com.jieyi.appStore"]?@"1":@"0";
    [sessionManager.requestSerializer setValue:bundVer forHTTPHeaderField:@"isShop"];
    
    NSString *token = [Manager takeoutTokenkey:access_token];
    if (token && ![token isEqualToString:@""]) {
        [sessionManager.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    if(time ==0)
      
        sessionManager.requestSerializer.timeoutInterval = 10.0f;
    else
        sessionManager.requestSerializer.timeoutInterval = time;
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
 /*
    //设置http body
    NSMutableDictionary *newBody = [NSMutableDictionary dictionaryWithDictionary:body];
     [newBody setObject:@"ios" forKey:@"os"];
     [newBody setObject:kAppVersion forKey:@"ver"];
     [newBody setObject:@"" forKey:@"uid"];
    */
    //创建task
    //[NSString stringWithFormat:@"%@%@",serviseIP,url]
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy = securityPolicy;

    NSString* url0 = [NSString stringWithFormat:@"%@%@",serviseIP,url];
    WeakSelf(self);
    NSURLSessionTask *sessionTask =
    [sessionManager POST:url0 parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(imagelist!= nil){
            for (int i = 0; i < imagelist.count; i++) {
                UIImage *img = imagelist[i];
                if(img == nil) continue;
                //上传
                [formData appendPartWithFileData:UIImagePNGRepresentation(img) name:[NSString stringWithFormat:@"image[%d]",i] fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/jpg"];
            }
        }
        NSLog(@"asd");
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *httpresonse = (NSHTTPURLResponse*)task.response;
        if (httpresonse.statusCode == 200) {
             block(responseObject,httpresonse.statusCode,NSLocalizedString(@"请求成功", nil));
        }
        else{
            block(nil,httpresonse.statusCode,[weakself getErroMsg:httpresonse.statusCode]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *responses = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = responses.statusCode;
        if (statusCode == 402) {
            //挤下线
            [weakself dismissLoading];
            [weakself LogoutRemind];
        }else{
            block(nil,error.code,[weakself getErroMsg:error.code]);
        }
    }];
    
    return sessionTask;
}

+(NSURLSessionTask*)path:(NSString*)url getReq:(NSDictionary*)body  loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block {
    
    //设置http head
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager setSecurityPolicy:[self customSecurityPolicy]];
//    [sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    [sessionManager.requestSerializer setValue:[self getUUidFun] forHTTPHeaderField:@"uuid"];
    [sessionManager.requestSerializer setValue:@"0" forHTTPHeaderField:@"versiontype"];
    [sessionManager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"ver"];
    [sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];
    [sessionManager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"phoneOs"];
    [sessionManager.requestSerializer setValue:[[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"en":@"zh-CN" forHTTPHeaderField:@"language"];
    [sessionManager.requestSerializer setValue:PlatformCode forHTTPHeaderField:@"platformCode"];
    NSString *bundVer = [[self getBundleID] isEqualToString:@"com.jieyi.appStore"]?@"1":@"0";
    [sessionManager.requestSerializer setValue:bundVer forHTTPHeaderField:@"isShop"];
    
    NSString *token = [Manager takeoutTokenkey:access_token];
    if (token && ![token isEqualToString:@""]) {
        [sessionManager.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    if(time ==0)
        
        sessionManager.requestSerializer.timeoutInterval = 10.0f;
    else
        sessionManager.requestSerializer.timeoutInterval = time;
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    /*
     //设置http body
     NSMutableDictionary *newBody = [NSMutableDictionary dictionaryWithDictionary:body];
     [newBody setObject:@"ios" forKey:@"os"];
     [newBody setObject:kAppVersion forKey:@"ver"];
     [newBody setObject:@"" forKey:@"uid"];
     */
    //创建task
    //[NSString stringWithFormat:@"%@%@",serviseIP,url]
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy = securityPolicy;
    
    NSString* url0 = [NSString stringWithFormat:@"%@%@",serviseIP,url];
    WeakSelf(self);
    NSURLSessionTask *sessionTask = [sessionManager GET:url0 parameters:body progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpresonse = (NSHTTPURLResponse*)task.response;
        
        if (httpresonse.statusCode == 200) {
            block(responseObject,httpresonse.statusCode,NSLocalizedString(@"请求成功", nil));
        }
        else{
            block(nil,httpresonse.statusCode,[weakself getErroMsg:httpresonse.statusCode]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *responses = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = responses.statusCode;
        if (statusCode == 402) {
            //挤下线
            [weakself dismissLoading];
            [weakself LogoutRemind];
        }else{
            block(nil,error.code,[weakself getErroMsg:error.code]);
        }
    }];
 
    return sessionTask;
}

+(NSURLSessionTask*)path:(NSString*)url image:(UIImage *)image param:(NSDictionary*)parameters loadingTime:(NSInteger)time callbackBlock:(RequestCallBackBlock)block{
    //设置http head
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager setSecurityPolicy:[self customSecurityPolicy]];
//    [sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    [sessionManager.requestSerializer setValue:[self getUUidFun] forHTTPHeaderField:@"uuid"];
    [sessionManager.requestSerializer setValue:@"0" forHTTPHeaderField:@"versiontype"];
    [sessionManager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"ver"];
    [sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];
    [sessionManager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"phoneOs"];
    [sessionManager.requestSerializer setValue:[[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"en":@"zh-CN" forHTTPHeaderField:@"language"];
    [sessionManager.requestSerializer setValue:PlatformCode forHTTPHeaderField:@"platformCode"];
    NSString *bundVer = [[self getBundleID] isEqualToString:@"com.jieyi.appStore"]?@"1":@"0";
    [sessionManager.requestSerializer setValue:bundVer forHTTPHeaderField:@"isShop"];

    NSString *token = [Manager takeoutTokenkey:access_token];
    if (token && ![token isEqualToString:@""]) {
        [sessionManager.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    if(time ==0)
        sessionManager.requestSerializer.timeoutInterval = 10.0f;
    else
        sessionManager.requestSerializer.timeoutInterval = time;
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    /*
     //设置http body
     NSMutableDictionary *newBody = [NSMutableDictionary dictionaryWithDictionary:body];
     [newBody setObject:@"ios" forKey:@"os"];
     [newBody setObject:kAppVersion forKey:@"ver"];
     [newBody setObject:@"" forKey:@"uid"];
     */
    //创建task
    //[NSString stringWithFormat:@"%@%@",serviseIP,url]
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy = securityPolicy;
    
    NSString* url0 = [NSString stringWithFormat:@"%@%@",serviseIP,url];
    WeakSelf(self);
    NSURLSessionTask *sessionTask = [sessionManager POST:url0 parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"image" fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpresonse = (NSHTTPURLResponse*)task.response;
        if (httpresonse.statusCode == 200) {
            block(responseObject,httpresonse.statusCode,NSLocalizedString(@"请求成功", nil));
        }
        else{
            block(nil,httpresonse.statusCode,[weakself getErroMsg:httpresonse.statusCode]);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *responses = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = responses.statusCode;
        if (statusCode == 402) {
            //挤下线
            [weakself dismissLoading];
            [weakself LogoutRemind];
        }else{
            block(nil,error.code,[weakself getErroMsg:error.code]);
        }
    }];
    
    return sessionTask;
}

+(NSString*)getErroMsg:(NSInteger)code{
    
    switch (code) {
        case 404:
            return NSLocalizedString(@"网络异常，请稍后重试", nil);
        case -1009:
            return NSLocalizedString(@"网络异常，请稍后重试", nil);
        case 500:
            return NSLocalizedString(@"网络异常，请稍后重试", nil);
        case 700:
            return NSLocalizedString(@"接口出现异常", nil);
        case 800:
            return NSLocalizedString(@"在另一部手机上登录", nil);
        default:
            break;
    }
    return NSLocalizedString(@"未定义错误", nil);
}

+(void)LogoutRemind{
    UIAlertController*   sheetVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"您的账号已在别处登录", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    WeakSelf(self);
    UIAlertAction*  sheetBtn1=[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself loginout];
    }];
    [sheetVC addAction:sheetBtn1];
    [sheetBtn1 setValue:[UIColor colorWithRGBHex:@"#323236"] forKey:@"titleTextColor"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:sheetVC animated:YES completion:nil];
}

static NSData *mCerData;
+ (AFSecurityPolicy *)customSecurityPolicy {
    
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    if(mCerData == nil){
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];//证书的路径
        mCerData = [NSData dataWithContentsOfFile:cerPath];
    }
    
   
    if(mCerData==nil)return nil;
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES;
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:mCerData, nil];
    
    return securityPolicy;
}

@end
