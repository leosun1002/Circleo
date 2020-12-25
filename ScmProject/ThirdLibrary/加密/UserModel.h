//
//  UserModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/5.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic,strong) NSString *attentionAmount;
@property(nonatomic,strong) NSString *background;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *cards;
@property(nonatomic,strong) NSString *cityId;
@property(nonatomic,strong) NSString *cityName;
@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString *fansAmount;
@property(nonatomic,strong) NSString *friendsAmount;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *isAppraise;
@property(nonatomic,strong) NSString *isFans;
@property(nonatomic,strong) NSString *isLike;
@property(nonatomic,strong) NSString *isModCards;
@property(nonatomic,strong) NSString *likeAmount;
@property(nonatomic,strong) NSString *money;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *photo;
@property(nonatomic,strong) NSString *postcode;
@property(nonatomic,strong) NSString *regionId;
@property(nonatomic,strong) NSString *regionName;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSArray<NSDictionary *> *tagsList;

@end

NS_ASSUME_NONNULL_END
