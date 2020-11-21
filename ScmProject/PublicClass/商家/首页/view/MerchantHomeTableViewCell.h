//
//  MerchantHomeTableViewCell.h
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headV;

@end

NS_ASSUME_NONNULL_END
