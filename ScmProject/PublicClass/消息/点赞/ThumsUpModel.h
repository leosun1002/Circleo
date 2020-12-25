//
//  ThumsUpModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/17.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThumsUpModel : NSObject

@property(nonatomic, strong) NSString * createDate;// (string, optional): 距离点赞创建时间 ,
@property(nonatomic, strong) NSString * flag;// (string, optional): 点赞类型 1点赞帖子 2点赞评论 ,
@property(nonatomic, strong) NSString * msgid;// (string, optional): 消息id ,
@property(nonatomic, strong) NSString * name;//(string, optional): 点赞人 名称 ,
@property(nonatomic, strong) NSString * photo;// (string, optional): 点赞人 头像 ,
@property(nonatomic, strong) NSString * postId;// (string, optional): 帖子id ,
@property(nonatomic, strong) NSString * userId;// (string, optional): 点赞人id
@end

NS_ASSUME_NONNULL_END
