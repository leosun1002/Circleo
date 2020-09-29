//
//  RatetoCNY.m
//  CMC
//
//  Created by 叶中刚 on 2018/3/1.
//

#import "RatetoCNY.h"

@implementation RatetoCNY

+(NSString* )rate:(NSString* )str{
    if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"CNY"]) {
        
        return  [GaoJingDu quZero:str];
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"AUD"]){
        
        return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.2013]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"HKD"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*1.2342]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"TWD"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*4.6146]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"USD"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.1578]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"EUR"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.1281]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"GBP"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.1131]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"INR"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*10.2502]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"JPY"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*16.8544]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"KRW"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*169.9325]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"MYR"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.6151]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"NZD"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.2161]];
        
    }else if ([[Manager takeoutTokenkey:@"huobi"] isEqualToString:@"SGD"]){
        
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*0.2082]];
        
    }else {
         return [GaoJingDu quZero:[NSString stringWithFormat:@"%.4f",[str floatValue]*1]];
        
    }
    
    
    
    
    
    
    
    
}

@end
