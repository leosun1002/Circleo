//
//  MyAppointModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/19.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAppointModel : NSObject

@property(nonatomic,strong) NSString *businessEnglishName;// (string, optional): 商家英文名称 ,
@property(nonatomic,strong) NSString *businessId;// (string, optional): 商家id ,
@property(nonatomic,strong) NSString *businessName;// (string, optional): 商家名称 ,
@property(nonatomic,strong) NSString *code;// (string, optional): 订单号 ,
@property(nonatomic,strong) NSString *goodsEnglishName;// (string, optional): 商品英文名称 ,
@property(nonatomic,strong) NSString *goodsId;// (string, optional): 商品id ,
@property(nonatomic,strong) NSString *goodsImg;// (string, optional): 商品封面 ,
@property(nonatomic,strong) NSString *goodsName;// (string, optional): 商品名称 ,
@property(nonatomic,strong) NSString *appointId;// (string, optional): ID ,
@property(nonatomic,strong) NSString *meetTime;// (string, optional): 预约时间 ,
@property(nonatomic,strong) NSString *passTime;// (string, optional): 预约时间 ,
@property(nonatomic,strong) NSString *name;// (string, optional): 会员名称 ,
@property(nonatomic,strong) NSString *phone;// (string, optional): 会员手机号 ,
@property(nonatomic,strong) NSString *status;// (string, optional): 状态 0 预约中 1 预约成功 2预约失败 ,
@property(nonatomic,strong) NSString *userId;// (string, optional): 会员id
@property(nonatomic,strong) NSString *createTime;
@property(nonatomic,strong) NSString *refuseTime;

@end

NS_ASSUME_NONNULL_END
