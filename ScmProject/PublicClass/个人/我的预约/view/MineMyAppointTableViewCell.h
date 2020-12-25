//
//  MineMyAppointTableViewCell.h
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAppointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineMyAppointTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) MyAppointModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *smallHeadV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

NS_ASSUME_NONNULL_END
