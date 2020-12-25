//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by lsjr on 16/8/30.
//  Copyright © 2016年 ls51. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTagListView;
typedef void(^TapHandle)(NSInteger tag);
@protocol ZWTagListViewDelegate <NSObject>

@optional
- (CGFloat)columnMarginInWaterflowLayout:(ZWTagListView *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZWTagListView *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZWTagListView *)waterflowLayout;
@end

@interface ZWTagListView : UIView
@property (nonatomic, weak) id<ZWTagListViewDelegate> delegate;
@property(nonatomic,retain)UIColor*GBbackgroundColor;
@property(nonatomic)UIColor*signalTagColor;

-(void)setTagWithTagArray:(NSArray*)arr;
@property(nonatomic,strong) TapHandle  Handle;
@end
