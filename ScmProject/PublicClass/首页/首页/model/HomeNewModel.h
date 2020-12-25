//
//  HomeNewModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/7.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNewModel : NSObject

@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *likeAmount;
@property(nonatomic,strong)NSString *lastId;
@property(nonatomic,strong)NSString *isLike;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)CGFloat height;

@end

NS_ASSUME_NONNULL_END
