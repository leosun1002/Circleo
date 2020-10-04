//
//  HomeUserInfoHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeUserInfoHeader.h"

@implementation HomeUserInfoHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HomeUserInfoHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self addBezierPath];
    }
    return self;
}

-(void)addBezierPath{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 240) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgview.bounds;
    maskLayer.path = path1.CGPath;
    self.bgview.layer.mask = maskLayer;
}

- (IBAction)fansClick:(id)sender {
    [self.subject sendNext:@""];
}

- (IBAction)followClick:(id)sender {
    [self.subject sendNext:@""];
}

@end
