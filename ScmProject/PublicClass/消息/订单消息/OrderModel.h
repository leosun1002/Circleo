//
//  OrderModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/17.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property(nonatomic,strong) NSString *businessId;// (string, optional): 商家id ,
@property(nonatomic,strong) NSString *businessImg;// (string, optional): 商家封面 ,
@property(nonatomic,strong) NSString *businessName;// (string, optional): 商家 名称 ,
@property(nonatomic,strong) NSString *createDate;// (string, optional): 消息发送时间 ,
@property(nonatomic,strong) NSString *flag;// (string, optional): 1订单支付成功提醒 2订单使用提醒 3订单退款提醒 4退款申请通过提醒 5退货退款申请通过提醒 6订单预约成功提醒 ,
@property(nonatomic,strong) NSString *mainid;// (string, optional): 消息id ,
@property(nonatomic,strong) NSString *orderId;// (string, optional): 订单id
@end

NS_ASSUME_NONNULL_END
