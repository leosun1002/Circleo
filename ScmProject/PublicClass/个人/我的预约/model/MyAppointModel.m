//
//  MyAppointModel.m
//  ScmProject
//
//  Created by leosun on 2020/12/19.
//  Copyright © 2020 session. All rights reserved.
//

#import "MyAppointModel.h"

@implementation MyAppointModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"appointId":@"id"};
}

@end
