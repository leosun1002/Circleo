//
//  MerchantOrderFooter.m
//  ScmProject
//
//  Created by leosun on 2020/10/7.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantOrderFooter.h"

@implementation MerchantOrderFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantOrderFooter" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self addBeizierPath];
    }
    return self;
}

-(void)addBeizierPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth - 20, 20) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth - 20, 20);
    maskLayer.path = path.CGPath;
    self.topView.layer.mask = maskLayer;
    
    //从这里开始就是设置富文本的属性
    NSString *oldPrice = @"＄299.9";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    //下面开始是设置线条的风格：
    //第一个参数addAttribute:是设置要中线（删除线）还是下划线。
    //NSStrikethroughStyleAttributeName：这种是从文本中间穿过，也就是删除线。
    //NSUnderlineStyleAttributeName：这种是下划线。

    //第二个参数value：是设置线条的风格：虚线，实现，点线......
    //第二参数需要同时设置Pattern和style才能让线条显示。
    //第三个参数range:是设置线条的长度，切记，不能超过字符串的长度，否则会报错。
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:NSMakeRange(0, oldPrice.length)];

    //下列是设置线条的颜色
    //第一个参数就是选择设置中线的颜色还是下划线的颜色，如果上面选择的是中线，这里就要选择中线，否则颜色设置不上去。
    //第二个参数很简单，就是颜色而已。
    //第三个参数：同上。
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRGBHex:@"#999999"] range:NSMakeRange(0, oldPrice.length)];
    [self.oldPriceLabel setAttributedText:attri];

}
@end
