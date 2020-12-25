//
//  MineChangeNickNameVC.h
//  ScmProject
//
//  Created by leosun on 2020/10/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineChangeNickNameVC : BaseViewController

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)RACSubject *subject;
@property(nonatomic,strong)NSString *content;

@end

NS_ASSUME_NONNULL_END
