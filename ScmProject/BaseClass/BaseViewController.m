//
//  BaseViewController.m
//  yiTang
//
//  Created by zhoudong on 16/1/11.
//  Copyright © 2016年 zhoudong. All rights reserved.
//

#import "BaseViewController.h"
#import "Masonry.h"

@interface BaseViewController (){
    
    UIView* mNavBar;
    UILabel* mTitleLab;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //隐藏navbar
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    NSLog(@"当前VC：%@",[self class]);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)setBanar:(NSString*)titles{

    [self setBanar:titles hiddeBack:YES];
   
}

-(void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
}
//设置navbarView
-(void)setBanar:(NSString*)titles hiddeBack:(BOOL)show{
    
    if(mTitleLab != nil){
        
        mTitleLab.text = titles;
        return;
    }
    

    UIView* navView = [[UIView alloc]init];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mNavBar = navView];

    //添加给view1约束
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@navBarHeight);
        //设置代码可以更简单（效果与上面的是一样的）
        //make.edges.equalTo(superView).with.insets(pading);
    }];
    
    UILabel* titleLab = [[UILabel alloc] init];
    mTitleLab = titleLab;
    titleLab.textAlignment = 1;
//    titleLab.font = [UIFont systemFontOfSize:20.0];
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    titleLab.textColor = [UIColor colorWithRGBHex:@"#333333"];
   // titleLab.frame  = CGRectMake(0, 20, ScreenW, navBarHeight-20);
    titleLab.text = titles;
    [navView addSubview:titleLab];
    
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(navView.mas_bottom).with.offset(-5);
        make.left.equalTo(navView.mas_left).with.offset(45);
        make.right.equalTo(navView.mas_right).with.offset(-45);
        make.height.equalTo(@44);

    }];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRGBHex:@"#E6E6E6"];
    [navView addSubview:_baseLine = line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(navView.mas_bottom).with.offset(0);
        make.left.equalTo(navView.mas_left).with.offset(0);
        make.right.equalTo(navView.mas_right).with.offset(0);
        make.height.equalTo(@0.5);
        
    }];
    
    
    if (!show) {
        UIButton* backBtn  = [UIButton buttonWithType:0];
        [backBtn setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
        //backBtn.backgroundColor = [UIColor redColor];
        [navView addSubview:backBtn];
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(navView.mas_bottom).with.offset(-5);
            make.left.equalTo(navView.mas_left).with.offset(0);
           
            make.height.equalTo(@44);
            make.width.equalTo(@50);
            //设置代码可以更简单（效果与上面的是一样的）
            //make.edges.equalTo(superView).with.insets(pading);
        }];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
       /* WeakSelf(self);
        [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }];*/
    }
}


-(UIView*)gerNavBar{
    
    return  mNavBar;
}

-(void)hiddenBannar{

   if(!mNavBar)
       mNavBar.hidden = YES;
}
    
//-(UIViewController*)getRouterVc:(NSString*)string{
//    
//    return  [[HHRouter shared] matchController:string];
//}
//   
//+(void)setRouterVc:(NSString*)string controller:(id)vc{
//    
//   [[HHRouter shared] map:string toControllerClass:vc];
//}

    
- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
}

@end
