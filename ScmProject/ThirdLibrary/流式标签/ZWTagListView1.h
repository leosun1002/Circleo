//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by lsjr on 16/8/30.
//  Copyright © 2016年 ls51. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTagListView1;
typedef void(^TapHandle)(NSString *selectArr);
@protocol ZWTagListView1Delegate <NSObject>

@optional
- (CGFloat)columnMarginInWaterflowLayout:(ZWTagListView1 *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZWTagListView1 *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZWTagListView1 *)waterflowLayout;
@end

@interface ZWTagListView1 : UIView
@property (nonatomic, weak) id<ZWTagListView1Delegate> delegate;
@property(nonatomic,retain)UIColor*GBbackgroundColor;
@property(nonatomic)UIColor*signalTagColor;

-(void)setTagWithTagArray:(NSArray*)arr;
@property(nonatomic,strong) TapHandle  Handle;
@end
