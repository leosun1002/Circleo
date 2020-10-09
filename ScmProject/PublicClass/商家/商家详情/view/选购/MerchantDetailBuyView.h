//
//  MerchantDetailBuyView.h
//  ScmProject
//
//  Created by leosun on 2020/10/4.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MerchantDetailBuyView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) RACSubject *specSubject;
@property (nonatomic, strong) RACSubject *buySubject;

@end

NS_ASSUME_NONNULL_END
