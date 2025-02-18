//
//  MyTabBar.h
//  CustomTabbarViewController
//
//  Created by duanshengwu on 2019/7/11.
//  Copyright © 2019 D-James. All rights reserved.
//

typedef void(^PublishBlock)(void);

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTabBar : UITabBar

@property(nonatomic,copy)PublishBlock block;

@end

NS_ASSUME_NONNULL_END
