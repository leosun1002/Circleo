//
//  JieyiXieyiVC.m
//  ScmProject
//
//  Created by leosun on 2019/8/9.
//  Copyright © 2019 session. All rights reserved.
//

#import "JieyiXieyiVC.h"
#import <WebKit/WebKit.h>

@interface JieyiXieyiVC ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation JieyiXieyiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    NSString *titleStr = @"";
    NSString *contentStr = @"";
    if (self.type == 1) {
        titleStr = NSLocalizedString(@"界一科技用户服务协议", nil);
        contentStr = [[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"terms_eng":@"terms";
    }else if (self.type == 2) {
        titleStr = NSLocalizedString(@"法律声明和隐私权政策", nil);
        contentStr = [[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"law_eng":@"law";
    }else if (self.type == 3){
        titleStr = NSLocalizedString(@"域名在线服务政策", nil);
        contentStr = [[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"service_eng":@"service";
    }else if (self.type == 5){
        titleStr = NSLocalizedString(@"卡券说明", nil);
        contentStr = [[GDLocalizableController userLanguage] isEqualToString:ENGLISH]?@"question_eng":@"question";
    }
    [self setBanar:titleStr hiddeBack:NO];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:contentStr ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];

    [self createwebView:url];
}

- (void)createwebView:(NSURL *)url{
    WKWebView *webView = [[WKWebView alloc]init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(navBarHeight);
        make.bottom.equalTo(self.view);
    }];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    if (@available(iOS 11.0,*)) {
        webView.scrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

@end
