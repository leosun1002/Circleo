//
//  FansModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/17.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FansModel : NSObject

@property(nonatomic,assign) long isAttention;
@property(nonatomic,strong) NSString *fansAmount;
@property(nonatomic,strong) NSString *area;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *photo;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSString *createDate;

@end

NS_ASSUME_NONNULL_END
