//
//  FansFollowTableViewCell.h
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FansFollowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *flowBtn;
@property (strong, nonatomic) FansModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flowWidth;

@end

NS_ASSUME_NONNULL_END
