//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by lsjr on 16/8/30.
//  Copyright © 2016年 ls51. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTagListView2;
typedef void(^TapHandle)(NSString *selectArr);
@protocol ZWTagListView2Delegate <NSObject>

@optional
- (CGFloat)columnMarginInWaterflowLayout:(ZWTagListView2 *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZWTagListView2 *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZWTagListView2 *)waterflowLayout;
@end

@interface ZWTagListView2 : UIView
@property (nonatomic, weak) id<ZWTagListView2Delegate> delegate;
@property(nonatomic,retain)UIColor*GBbackgroundColor;
@property(nonatomic)UIColor*signalTagColor;

-(void)setTagWithTagArray:(NSArray*)arr;
@property(nonatomic,strong) TapHandle  Handle;
@end
