//
//  UserModel.m
//  ScmProject
//
//  Created by leosun on 2020/12/5.
//  Copyright © 2020 session. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc":@"description",@"userId":@"id"};
}

@end
