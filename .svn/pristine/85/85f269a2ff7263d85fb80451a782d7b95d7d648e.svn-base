//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by lsjr on 16/8/30.
//  Copyright © 2016年 ls51. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTagListView3;
typedef void(^TapHandle)(NSString *selectStr);
@protocol ZWTagListView3Delegate <NSObject>

@optional
- (CGFloat)columnMarginInWaterflowLayout:(ZWTagListView3 *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZWTagListView3 *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZWTagListView3 *)waterflowLayout;
@end

@interface ZWTagListView3 : UIView
@property (nonatomic, weak) id<ZWTagListView3Delegate> delegate;
@property(nonatomic,retain)UIColor*GBbackgroundColor;
@property(nonatomic)UIColor*signalTagColor;
@property(nonatomic,strong)NSString *selectName;

-(void)setTagWithTagArray:(NSArray*)arr;
@property(nonatomic,strong) TapHandle  Handle;
@end
