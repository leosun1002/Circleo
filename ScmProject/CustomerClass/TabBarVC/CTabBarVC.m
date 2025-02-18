//
//  CTabBarVC.m
//  ScmProject
//
//  Created by zhoudong on 2018/7/13.
//  Copyright © 2018年 session. All rights reserved.
//

#import "CTabBarVC.h"
//首页
#import "HomePageVC.h"
//商家
#import "MerchatHomeVC.h"
//消息
#import "MessageHomeVC.h"
//个人中心
#import "MineHomePageVC.h"

#import "MyTabBar.h"
#import "PublishHomeVC.h"

@interface CTabBarVC ()

@end

@implementation CTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyTabBar *tabbar = [MyTabBar new];
    WeakSelf(self);
    tabbar.block = ^{
        PublishHomeVC *publish = [[PublishHomeVC alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:publish];
        navigation.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakself presentViewController:navigation animated:YES completion:^{
            
        }];
    };
    [self setValue:tabbar forKey:@"tabBar"];


    //去掉线
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.backgroundColor = [UIColor clearColor];//根据自己的情况设置
        standardAppearance.shadowColor = [UIColor clearColor];//也可以设置为白色或任何颜色
        self.tabBar.standardAppearance = standardAppearance;
    }else{
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
        [UITabBar appearance].backgroundColor = [UIColor whiteColor];//根据自己的情况设置
    }

    HomePageVC *homeVC = [[HomePageVC alloc] init];
    [self controller:homeVC Title:NSLocalizedString(@"首页", nil) tabBarItemImage:@"home_n" tabBarItemSelectedImage:@"home_s"];
    MerchatHomeVC *merchantVC = [[MerchatHomeVC alloc] init];
    [self controller:merchantVC Title:NSLocalizedString(@"商家", nil) tabBarItemImage:@"mer_n" tabBarItemSelectedImage:@"mer_s"];
    MessageHomeVC *messageVC = [[MessageHomeVC alloc] init];
    [self controller:messageVC Title:NSLocalizedString(@"消息", nil) tabBarItemImage:@"message_n" tabBarItemSelectedImage:@"message_s"];
    MineHomePageVC *mineVC = [[MineHomePageVC alloc] init];
    [self controller:mineVC Title:NSLocalizedString(@"我的", nil) tabBarItemImage:@"my_n" tabBarItemSelectedImage:@"my_s"];
    self.viewControllers = @[homeVC,merchantVC,messageVC,mineVC];
    
}

- (void)controller:(UIViewController *)controller Title:(NSString *)title tabBarItemImage:(NSString *)image tabBarItemSelectedImage:(NSString *)selectedImage
{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *imageHome = [UIImage imageNamed:selectedImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setSelectedImage:imageHome];
 
//    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
//    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithRGBHex:@"#5151F0"] forKey:NSForegroundColorAttributeName];
//    [controller.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    self.tabBar.tintColor = [UIColor colorWithRGBHex:@"#333333"];
    
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor colorWithRGBHex:@"#333333"];
    } else {
        // Fallback on earlier versions
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
