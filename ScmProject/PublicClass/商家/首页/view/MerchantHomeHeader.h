//
//  MerchantHomeHeader.h
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantHomeHeader : UIView

@property(nonatomic,strong) RACSubject *subject;
@property(nonatomic,strong) RACSubject *pageSubject;
@end

NS_ASSUME_NONNULL_END
