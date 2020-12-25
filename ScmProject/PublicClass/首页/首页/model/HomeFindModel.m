//
//  HomeFindModel.m
//  ScmProject
//
//  Created by leosun on 2020/12/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeFindModel.h"

@implementation HomeFindCategorysModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"categoryId":@"id",@"desc":@"description"};
}

@end

@implementation HomeFindModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"findId":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"postCategorys":[HomeFindCategorysModel class]};
}

@end
