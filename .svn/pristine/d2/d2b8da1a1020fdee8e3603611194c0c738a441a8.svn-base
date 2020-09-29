//
//  GaoJingDu.m
//  3CBTC
//
//  Created by 叶中刚 on 2017/12/25.
//  Copyright © 2017年 叶中刚. All rights reserved.
//

#import "GaoJingDu.h"

@implementation GaoJingDu



+(NSString* )quZero:(NSString* )str{
      NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: str];
    return [NSString stringWithFormat:@"%@",num1];
}

//加号方法
+(NSString* )add:(NSArray* )array jindu:(NSString* )jindu{
    
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:[jindu integerValue] raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
     NSDecimalNumber *num3 = [num1 decimalNumberByAdding:num2 withBehavior:handel];
    
    return [NSString stringWithFormat:@"%@",num3];
 
}


//减号方法
+(NSString* )jian:(NSArray* )array jindu:(NSString* )jindu{
    
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:[jindu integerValue] raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    
    
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
    
    NSDecimalNumber *num3 = [num1 decimalNumberBySubtracting:num2 withBehavior:handel];
    
    
    return [NSString stringWithFormat:@"%@",num3];
    
    
}

//乘号方法
+(NSString *)cheng:(NSArray* )array jindu:(NSString* )jindu{
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    
    
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
    
  //  NSDecimalNumber *num3 = [num1 decimalNumberByMultiplyingBy:num2];
    
    
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:[jindu integerValue] raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *num_3 = [num1 decimalNumberByMultiplyingBy:num2 withBehavior:handel];
    return [NSString stringWithFormat:@"%@",num_3];
}

//除号方法
+(NSString* )chu:(NSArray* )array jindu:(NSString* )jindu{
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    
    
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
    
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:[jindu integerValue] raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *num_3 = [num1 decimalNumberByDividingBy:num2 withBehavior:handel];
    return [NSString stringWithFormat:@"%@",num_3];
}


//乘号方法
+(NSString *)chengbaoliu:(NSArray* )array jindu:(NSString* )jindu{
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
    //  NSDecimalNumber *num3 = [num1 decimalNumberByMultiplyingBy:num2];
    
    NSDecimalNumber *num_3 = [num1 decimalNumberByMultiplyingBy:num2];
    return [NSString stringWithFormat:@"%@",num_3];
}


//加号方法
+(NSString* )addbaoliu:(NSArray* )array jindu:(NSString* )jindu{
    
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
    NSDecimalNumber *num3 = [num1 decimalNumberByAdding:num2];
    
    return [NSString stringWithFormat:@"%@",num3];
    
}

//减号方法
+(NSString* )jianbaoliu:(NSArray* )array jindu:(NSString* )jindu{
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: [array firstObject]];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:[array lastObject]];
    NSDecimalNumber *num3 = [num1 decimalNumberBySubtracting:num2];
    return [NSString stringWithFormat:@"%@",num3];
    
    
}



//数值比较
+ (BOOL)number:(NSString *)number1 dayuB:(NSString *)number2{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return NO;
    } else if (result == NSOrderedSame) {
        return YES;
    } else if (result == NSOrderedDescending) {
        return NO;
    }
    return NO;
}

+(NSString *)doubleToString:(double)val{
    NSString *dStr      = [NSString stringWithFormat:@"%f", val];
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dStr];
    return [dn stringValue];
}
@end
