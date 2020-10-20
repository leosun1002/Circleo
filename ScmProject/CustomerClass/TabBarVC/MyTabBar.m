//
//  MyTabBar.m
//  CustomTabbarViewController
//
//  Created by duanshengwu on 2019/7/11.
//  Copyright © 2019 D-James. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar ()

@property (strong, nonatomic) UIButton *centerTabBarBtn;

@end

@implementation MyTabBar

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#define iPhoneX ((ScreenHeight == 812.0 || ScreenHeight == 896.0) ? YES : NO)
#define kBottomSafeSpace (iPhoneX ? 34.0 : 0.0)

- (instancetype)init{
    if (self = [super init]){
        [self initView];
    }
    return self;
}

- (void)initView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, kBottomSafeSpace+49+20)];
    backView.backgroundColor = [UIColor whiteColor];
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"tabbar_bg"];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(0, 0, ScreenWidth, 65);
    imageView.backgroundColor = [UIColor colorWithRGBHex:@"F7F5FA"];
    [backView addSubview:imageView];

    [self insertSubview:backView atIndex:0];
    
    // 去除顶部横线
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];

}

// layoutSubviews遍历子控件寻找UITabBarButton，给UITabBarButton重新设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = 50;
    self.centerTabBarBtn.frame = CGRectMake((ScreenWidth-width)/2, -30, width, width);
    
    CGFloat tabBarButtonW = ScreenWidth / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {

        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {

            // 重新设置frame
            CGRect frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, 49);
            child.frame = frame;

            // 增加索引
            if (tabBarButtonIndex == 1) {
                tabBarButtonIndex++;
            }
            tabBarButtonIndex++;
        }
    }
}


////处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.centerTabBarBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerTabBarBtn.bounds, tempPoint)){
            //返回按钮
            return self.centerTabBarBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}


- (void)centerTabBarBtnEvent {
    !self.block?:self.block();
}


- (UIButton *)centerTabBarBtn {
    
    if (_centerTabBarBtn == nil) {
        _centerTabBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_centerTabBarBtn];
        [_centerTabBarBtn setImage:[UIImage imageNamed:@"tabbar_pic"] forState:UIControlStateNormal];
        _centerTabBarBtn.adjustsImageWhenHighlighted = false;
        [_centerTabBarBtn addTarget:self action:@selector(centerTabBarBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _centerTabBarBtn;
}

@end
