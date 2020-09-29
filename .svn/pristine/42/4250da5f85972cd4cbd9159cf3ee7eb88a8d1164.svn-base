//
//  UITextField+Listening.m
//  Cloud Pro
//
//  Created by zhoudong on 2018/8/14.
//  Copyright © 2018年 yunzhuan. All rights reserved.
//

#import "UITextField+Listening.h"

@implementation UITextField (Listening)

-(NSString*)PreciseFigures:(int)figures{
    
    NSMutableString* mutabString = [NSMutableString new];
    NSString* content =  self.text;
    BOOL   encounterPoint = false;
    int index = 0;
    char tempChar[content.length];
    strcpy(tempChar,(char *)[content UTF8String]);
    
    for(int a=0 ;a<content.length;a++){
       char c = tempChar[a];
        if(a==0 && c=='0' && content.length>1){
             char cc = tempChar[1];
             if(cc != '.') continue;
        }
        if((c>='0'&&c<='9') || c=='.' ){
            if( encounterPoint==true  &&  c == '.' ) continue;
            if(c == '.') encounterPoint = true;
           
            if(index > figures) continue;
            if(encounterPoint == true) index++;
            
            if(figures == 0 && c == '.') continue;
            [mutabString appendString:[NSString stringWithFormat:@"%c",c]];
        }
    }
    return mutabString;
}


//汉字小bug
-(NSString*)controlLength:(int)length{
    
    
    NSMutableString* mutabString = [NSMutableString new];
    NSString* content =  self.text;
    
    char tempChar[content.length];
    strcpy(tempChar,(char *)[content UTF8String]);
    
    for(int a=0 ;a<content.length;a++){
        
       if(mutabString.length >= length) break;
        
       char c = tempChar[a];
    
       if(c>='0'&&c<='9')
       
         [mutabString appendString:[NSString stringWithFormat:@"%c",c]];
       }
    
    return mutabString;
}

@end
