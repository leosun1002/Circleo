//
//  CommentsModel.m
//  ScmProject
//
//  Created by leosun on 2020/12/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "CommentsModel.h"

@implementation CommentsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"comid":@"id"};
}
@end
