//
//  HCToast.h
//  HeCampus-whty
//
//  Created by 兰柳锋 on 16/9/20.
//  Copyright © 2016年 com.whty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^ToastBlock)(void);

@interface HCToast : NSObject

#pragma mark-中间显示
/**
 *  中间显示
 *
 *  @param text 内容
 */
+ (void)showCenterWithText:(NSString *)text;
/**
 *  中间显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;

/**
 *  中间显示+自定义停留时间
 *
 *  @param text     内容
 *  @param block 回调
 */
+ (void)showCenterWithText:(NSString *)text withBlcok:(ToastBlock)block;

#pragma mark-上方显示
/**
 *  上方显示
 *
 *  @param text 内容
 */
+ (void)showTopWithText:(NSString *)text;
/**
 *  上方显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;
/**
 *  上方显示+自定义距顶端距离
 *
 *  @param text      内容
 *  @param topOffset 到顶端距离
 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;
/**
 *  上方显示+自定义距顶端距离+自定义停留时间
 *
 *  @param text      内容
 *  @param topOffset 到顶端距离
 *  @param duration  停留时间
 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

#pragma mark-下方显示
/**
 *  下方显示
 *
 *  @param text 内容
 */
+ (void)showBottomWithText:(NSString *)text;
/**
 *  下方显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration;
/**
 *  下方显示+自定义距底端距离
 *
 *  @param text         内容
 *  @param bottomOffset 距底端距离
 */
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;
/**
 *  下方显示+自定义距底端距离+自定义停留时间
 *
 *  @param text         内容
 *  @param bottomOffset 距底端距离
 *  @param duration     停留时间
 */
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;

@end
