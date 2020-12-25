//
//  HobbyModel.h
//  ScmProject
//
//  Created by leosun on 2020/12/4.
//  Copyright © 2020 session. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HobbyModel : NSObject

@property(nonatomic,strong)NSString *name;
//是否选择
@property(nonatomic,assign)bool ifSelect;
@property(nonatomic,strong)NSString *hobbyId;

@end

NS_ASSUME_NONNULL_END
