//
//  BaseViewController.h
//  yiTang
//
//  Created by zhoudong on 16/1/11.
//  Copyright © 2016年 zhoudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,weak)UIView *baseLine;

//设置tabbar 和title内容
-(void)setBanar:(NSString*)titles;

//左边返回按钮是否显示
-(void)setBanar:(NSString*)titles hiddeBack:(BOOL)show;

//隐藏navbar
-(void)hiddenBannar;

//获取navbar
-(UIView*)gerNavBar;
    
//HHRouter地址换VC
//-(UIViewController*)getRouterVc:(NSString*)string;

//+(void)setRouterVc:(NSString*)string controller:(id)vc;
@end
