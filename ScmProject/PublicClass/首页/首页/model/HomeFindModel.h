//
//  HomeFindModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/16.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFindCategorysModel : NSObject

@property(nonatomic,strong) NSString *categoryId;
@property(nonatomic,strong) NSString *parentId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *link;

@end

@interface HomeFindModel : NSObject

@property(nonatomic,strong) NSString *findId;
@property(nonatomic,strong) NSString *parentId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,copy) NSArray <HomeFindCategorysModel *> *postCategorys;
@end

NS_ASSUME_NONNULL_END
