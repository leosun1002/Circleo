//
//  HomePageChildVC.h
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePageChildVC : BaseViewController

@property(nonatomic,assign) int type;
@property(nonatomic,strong) UINavigationController *navigation;
-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
