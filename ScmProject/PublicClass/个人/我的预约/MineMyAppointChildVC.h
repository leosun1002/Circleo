//
//  MineMyAppointChildVC.h
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineMyAppointChildVC : BaseViewController

@property(nonatomic,strong)UINavigationController *navigation;
@property(nonatomic,assign)long type;

-(void)refreshData;
@end

NS_ASSUME_NONNULL_END
