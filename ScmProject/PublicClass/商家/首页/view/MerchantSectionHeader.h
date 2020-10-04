//
//  MerchantSectionHeader.h
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantSectionHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UIView *seqView;
@property (strong, nonatomic) RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
