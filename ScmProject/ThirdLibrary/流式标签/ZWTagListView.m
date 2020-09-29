//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by lsjr on 16/8/30.
//  Copyright © 2016年 ls51. All rights reserved.
//

#import "ZWTagListView.h"
#define HORIZONTAL_PADDING 20.f
#define VERTICAL_PADDING   8.0f
static const CGFloat XMGDefaultColumnMargin = 10;
static const CGFloat XMGDefaultRowMargin = 10;
static const UIEdgeInsets XMGDefaultEdgeInsets = {10, 10, 10, 10};

@interface ZWTagListView(){
    CGRect previousFrame ;
    int totalHeight ;
}
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;
@end

@implementation ZWTagListView

#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return XMGDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return XMGDefaultColumnMargin;
    }
}
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return XMGDefaultEdgeInsets;
    }
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        totalHeight=0;
        self.frame=frame;
    }
    return self;
}

-(void)setTagWithTagArray:(NSArray*)arr{
    
    previousFrame = CGRectMake(XMGDefaultEdgeInsets.top, XMGDefaultEdgeInsets.left, 0, 0);
    [arr enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        
        UILabel*tag = [[UILabel alloc]initWithFrame:CGRectZero];
        tag.tag = 100+idx;
        tag.textAlignment = NSTextAlignmentCenter;
        tag.textColor = [UIColor colorWithRGBHex:@"#55555D"];
        tag.font = [UIFont systemFontOfSize:13];
        tag.text = str;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        CGSize Size_str = [str sizeWithAttributes:attrs];
        
        Size_str.width += HORIZONTAL_PADDING*2;
        Size_str.height += VERTICAL_PADDING*2;
        
        CGRect newRect = CGRectZero;
    
        if (self->previousFrame.origin.x + self->previousFrame.size.width + Size_str.width + 2 * self.columnMargin > self.bounds.size.width) {
            newRect.origin = CGPointMake(XMGDefaultEdgeInsets.left, self->previousFrame.origin.y + Size_str.height + self.rowMargin);
        }else {
            if(idx == 0){
                newRect.origin = CGPointMake(self->previousFrame.origin.x + self->previousFrame.size.width , self->previousFrame.origin.y);
            }else{
                newRect.origin = CGPointMake(self->previousFrame.origin.x + self->previousFrame.size.width + self.columnMargin, self->previousFrame.origin.y);
            }
        }
        self->totalHeight = Size_str.height+newRect.origin.y;
        newRect.size = Size_str;
        [tag setFrame:newRect];
        if(self->_signalTagColor){
            tag.backgroundColor = self->_signalTagColor;
            tag.layer.borderColor = tag.backgroundColor.CGColor;
            tag.layer.borderWidth = 1.f;
            tag.layer.cornerRadius = 16.f;
            tag.layer.masksToBounds = YES;
        }else{
            tag.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
        }
        
        self->previousFrame = tag.frame;
        [self setHight:self andHight:self->totalHeight+  XMGDefaultEdgeInsets.bottom];
        
        [self addSubview:tag];
        tag.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTag:)];
        [tag addGestureRecognizer:tap];
    }];
    
    if(_GBbackgroundColor){
        self.backgroundColor = _GBbackgroundColor;
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}
#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}

#pragma mark - 
-(void)tapTag:(UITapGestureRecognizer *)tap
{
    UILabel *lab = (UILabel *)tap.view;
    !self.Handle? :self.Handle(lab);
}

@end
