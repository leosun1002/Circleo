//
//  HomeFindFooterReusableView.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeFindFooterReusableView.h"

@implementation HomeFindFooterReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addBeizierPath];
}

-(void)addBeizierPath{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth-20, 20) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = path1.CGPath;
    self.bgView.layer.mask = maskLayer;
}
@end
