//
//  CommentsModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/17.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsModel : NSObject

@property(nonatomic, strong) NSString* appraiseId ;//(string, optional): 评论id ,
@property(nonatomic, strong) NSString* createDate ;//(string, optional): 距离点赞创建时间 ,
@property(nonatomic, strong) NSString* flag ;//(string, optional): 评论类型 1 评论作品 2回复评论 3作品提及 4评论提及 ,
@property(nonatomic, strong) NSString* comid ;//(string, optional): 消息id ,
@property(nonatomic, strong) NSString* name ;//(string, optional): 评论人 名称 ,
@property(nonatomic, strong) NSString* photo ;//(string, optional): 评论人 头像 ,
@property(nonatomic, strong) NSString* postId ;//(string, optional): 帖子id ,
@property(nonatomic, strong) NSString* title ;//(string, optional): 评论内容 ,
@property(nonatomic, strong) NSString* userId ;//(string, optional): 评论人id
@end

NS_ASSUME_NONNULL_END
