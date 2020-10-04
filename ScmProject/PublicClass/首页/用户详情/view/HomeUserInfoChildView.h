//
//  HomeUserInfoChildView.h
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeUserInfoChildView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
