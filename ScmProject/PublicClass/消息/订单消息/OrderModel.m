//
//  OrderModel.m
//  ScmProject
//
//  Created by leosun on 2020/12/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"mainid":@"id"};
}
@end
