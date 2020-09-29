//
//  BindAccountChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "BindAccountChildVC.h"

@interface BindAccountChildVC ()

@property (weak, nonatomic) IBOutlet UIButton *notBindBtn;

@end

@implementation BindAccountChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.notBindBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#BFBFCB"].CGColor;
    self.notBindBtn.layer.borderWidth = [[UIScreen mainScreen] scale] * 0.5;
}


@end
