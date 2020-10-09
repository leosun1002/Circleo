//
//  MerchantBuyRightTableViewCell.h
//  ScmProject
//
//  Created by leosun on 2020/10/4.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantBuyRightTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *specView;
@property (strong, nonatomic) RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
