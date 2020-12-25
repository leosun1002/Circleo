//
//  FindTitleDetailVC.h
//  ScmProject
//
//  Created by leosun on 2020/11/20.
//  Copyright © 2020 session. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeFindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindTitleDetailVC : BaseViewController
@property (strong, nonatomic) NSString *titleStr;
@property(nonatomic,strong) HomeFindCategorysModel *model;

@end

NS_ASSUME_NONNULL_END
