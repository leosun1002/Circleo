//
//  HomeGraphicFirstHeader.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeGraphicFirstHeader.h"
#import "UIView+ZYTagView.h"

@implementation HomeGraphicFirstHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HomeGraphicFirstHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self addBezierPath];
        [self addScrollView];
        [self setData];
    }
    return self;
}

-(void)addBezierPath{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 30) byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.botView.bounds;
    maskLayer.path = path1.CGPath;
    self.botView.layer.mask = maskLayer;
}

-(void)addScrollView{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 500)];
    scroll.contentSize = CGSizeMake(ksrcwidth * 5, 0);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    [self.bgView addSubview:_scroll = scroll];
}

-(void)setData{
    for (int i = 0; i<5; i++) {
        ZYTagImageView *imageView = [[ZYTagImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://bkimg.cdn.bcebos.com/pic/562c11dfa9ec8a13632798e0e049868fa0ec08fa6ad2?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxMTY=,g_7,xp_5,yp_5"]];
        imageView.delegate = self;
        imageView.zy_width = ksrcwidth;
        imageView.zy_height = 500;
        imageView.zy_x = ksrcwidth * i;
        imageView.zy_y = 0;
    
        // 添加标签
        ZYTagInfo *info1 = [ZYTagInfo tagInfo];
        info1.point = CGPointMake(30, 40);
        info1.title = @"我是一个标签";
        
        ZYTagInfo *info2 = [ZYTagInfo tagInfo];
        info2.proportion = ZYPositionProportionMake(0.5, 0.8);
        info2.title = @"点击图片，添加标签";
        
        [imageView addTagsWithTagInfoArray:@[info1, info2]];
        [self.scroll addSubview:imageView];
    }
}

- (void)tagImageView:(ZYTagImageView *)tagImageView tagViewActiveTapGesture:(ZYTagView *)tagView{
    NSLog(@"asd");
}

@end
