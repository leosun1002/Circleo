//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by lsjr on 16/8/30.
//  Copyright © 2016年 ls51. All rights reserved.
//

#import "ZWTagListView3.h"
#define HORIZONTAL_PADDING 20.f
#define VERTICAL_PADDING   8.0f
static const CGFloat XMGDefaultColumnMargin = 10;
static const CGFloat XMGDefaultRowMargin = 10;
static const UIEdgeInsets XMGDefaultEdgeInsets = {10, 10, 10, 10};

@interface ZWTagListView3(){
    CGRect previousFrame ;
    int totalHeight ;
}
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;
@end

@implementation ZWTagListView3

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
        tag.font = [UIFont systemFontOfSize:13];
        tag.text = str;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        CGSize Size_str = [str sizeWithAttributes:attrs];
        
        Size_str.width += HORIZONTAL_PADDING*2;
        Size_str.height += VERTICAL_PADDING*2;
        
        CGRect newRect = CGRectZero;
    
        if (self->previousFrame.origin.x + self->previousFrame.size.width + Size_str.width + 2 * self.columnMargin > self.bounds.size.width) {
            newRect.origin = CGPointMake(XMGDefaultEdgeInsets.left + 5, self->previousFrame.origin.y + Size_str.height + self.rowMargin);
        }else {
            if(idx == 0){
                newRect.origin = CGPointMake(self->previousFrame.origin.x + self->previousFrame.size.width + 5 , self->previousFrame.origin.y+10);
            }else{
                newRect.origin = CGPointMake(self->previousFrame.origin.x + self->previousFrame.size.width + self.columnMargin + 5, self->previousFrame.origin.y);
            }
        }
        self->totalHeight = Size_str.height+newRect.origin.y+10;
        newRect.size = Size_str;
        [tag setFrame:newRect];

        if ([str isEqualToString:self.selectName]) {
            tag.backgroundColor = [UIColor colorWithRGBHex:@"#2982FF"];
            tag.textColor = [UIColor whiteColor];
            tag.layer.cornerRadius = tag.height/2;
            tag.layer.masksToBounds = YES;
//            tag.layer.borderColor = self->_signalTagColor.CGColor;
//            tag.layer.borderWidth = 1.0f;
        }else{
            tag.backgroundColor = [UIColor colorWithRGBHex:@"#F2F6FA"];
            tag.textColor = [UIColor colorWithRGBHex:@"#58555E"];
            tag.layer.cornerRadius = tag.height/2;
            tag.layer.masksToBounds = YES;
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
    !self.Handle? :self.Handle(lab.text);
}

@end
