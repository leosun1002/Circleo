//
//  MerchantAppointView.h
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MerchantAppointView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) UINavigationController *navigation;

@end

NS_ASSUME_NONNULL_END
