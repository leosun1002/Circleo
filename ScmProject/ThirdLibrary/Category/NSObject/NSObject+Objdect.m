//
//  NSObject+Objdect.m
//  ScmProject
//
//  Created by zhoudong on 2018/7/10.
//  Copyright © 2018年 session. All rights reserved.
//

#import "NSObject+Objdect.h"
#import "UIImage+GIFImage.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation NSObject (Objdect)


-(void)showMsg:(NSString*)msg location:(LocaType)loca{
    if(msg == nil)return;
    
    if(loca == top){
        [HCToast showTopWithText:msg];
    }else if(loca == bottom){
        [HCToast showBottomWithText:msg];
    }else{
        [HCToast showCenterWithText:msg];
    }
    
}

-(void)showMsg:(NSString *)msg withBlcok:(ToastBlock)block{
    if(msg == nil)return;
    
    [HCToast showCenterWithText:msg withBlcok:block];

}

-(void)sendNotification:(NSString*)notName dataFun:(id)data{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notName object:data];
}

-(void)deleteNotification:(NSString*)notName observer:(id)obj{
    
    [[NSNotificationCenter defaultCenter] removeObserver:obj name:notName object:nil];
}

-(void)showLoading:(NSString*)msg  allowsOpOperation:(BOOL)allows{    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"加载中...", nil)];
//    UIImage *image = [UIImage imageWithGIFNamed:@"loading"];
//    [SVProgressHUD setInfoImage:image];
//    [SVProgressHUD setImageViewSize:CGSizeMake(60, 60)];
//    [SVProgressHUD setMinimumDismissTimeInterval:12];
    if(allows){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
}

-(void)dismissLoading{
    [SVProgressHUD dismiss];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        return nil;
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
-(NSString*)getUUidFun{
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    if(uuid == nil){
      uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"uuid"];
    }
    return uuid == nil?@"":uuid;
}

-(NSString*)getBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)removeSpaceAndNewline:(NSString *)str{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password
{
    NSRange range;
    BOOL result =NO;
    for(int i=0; i<[_termArray count]; i++){
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if(range.location != NSNotFound){
            result =YES;
        }
    }
    return result;
}

+ (NSString*) judgePasswordStrength:(NSString*) _password{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
        NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];

    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++){
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"]){
            intResult++;
        }
    }
    
    NSString* pswLevel = @"1";
    if (intResult <2){
        pswLevel = @"1";
    }
    
    else if (intResult == 2&&[_password length]>=8){
        pswLevel = @"2";
    }
    
    if (intResult > 2&&[_password length]>=8){
        pswLevel = @"3";
    }
    return pswLevel;
    
}

-(void)popToNav:(UINavigationController* )nav  withPopVC:(NSString* )vcStr{
    for (UIViewController *controller in nav.viewControllers) {
        if([controller isKindOfClass:NSClassFromString(vcStr)]){
            [nav popToViewController:controller animated:YES];
            break;
        }
    }
}

-(NSString *)replacePhoneWithStar:(NSString *)phone{
    if (phone.length <=6 ) return phone;
    return [phone stringByReplacingCharactersInRange:NSMakeRange(phone.length - 3, 3) withString:@"***"];
}

-(void)showErrorView:(UIView *)view withBlock:(ToastBlock)block{
    ShopEmptyView *errowView = [ShopEmptyView flagView];
    errowView.backgroundColor = [UIColor whiteColor];
    errowView.imgV.image = [UIImage imageNamed:@"error_data_bg"];
    errowView.contentLabel.text = NSLocalizedString(@"无网络，请检查网络连接~", nil);
    errowView.frame = CGRectMake(0, navBarHeight, ksrcwidth, ksrcheight - navBarHeight);
    errowView.reloadBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#C0C5CC"].CGColor;
    errowView.reloadBtn.layer.borderWidth = 1.0f;
    errowView.reloadBtn.hidden = NO;
    __weak typeof(ShopEmptyView *)weakView = errowView;
    [[errowView.reloadBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [weakView removeFromSuperview];
        !block?:block();
    }];
    [view addSubview:errowView];
}

-(void)loginin{
    //跳转控制器
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    //设置动画时间
    animation.type = kCATransitionReveal;
    //设置动画类型
    animation.subtype = kCATransitionFromBottom;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self getUserRootVC];
}

-(void)getUserRootVC{
    UIStoryboard* IndexStroy = [UIStoryboard storyboardWithName:@"Customer" bundle:nil];
    UIViewController *rooter = (UINavigationController*)[IndexStroy instantiateViewControllerWithIdentifier:@"BaseNavVC"];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = rooter;
}

-(void)loginout{
    BOOL loguser = [Manager clearUserTokenkey:Loginuser];
    if (loguser) {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.3];
        //设置动画时间
        animation.type = kCATransitionReveal;
        //设置动画类型
        animation.subtype = kCATransitionFromBottom;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
        [self getUserLoginVC];
    }else{
        [self showMsg:NSLocalizedString(@"退出失败", nil) location:centre];
    }
}

-(void)getUserLoginVC{
    UIStoryboard* IndexStroy = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *loginvc =  (UINavigationController*)[IndexStroy instantiateViewControllerWithIdentifier:@"BaseNavVC"];
    
    //跳转控制器
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = loginvc;

}
@end
