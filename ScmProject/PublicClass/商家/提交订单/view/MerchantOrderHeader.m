//
//  MerchantOrderHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/7.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantOrderHeader.h"

@interface MerchantOrderHeader ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation MerchantOrderHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantOrderHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self addBeizierPath];
    }
    return self;
}

-(void)addBeizierPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth - 20, 44) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth - 20, 44);
    maskLayer.path = path.CGPath;
    self.bgView.layer.mask = maskLayer;
}
@end
