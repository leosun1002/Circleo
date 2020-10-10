//
//  MineOrderEvaluateVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderEvaluateVC.h"
#import "MineOrderEvaluateDetailVC.h"
#import "MineChekEvaluateVC.h"

@interface MineOrderEvaluateVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;

@end

@implementation MineOrderEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
}

- (IBAction)evaluateClick:(id)sender {
//    MineOrderEvaluateDetailVC *evaluate = [[MineOrderEvaluateDetailVC alloc] init];
//    [self.navigationController pushViewController:evaluate animated:YES];
    
    MineChekEvaluateVC *check = [[MineChekEvaluateVC alloc] init];
    [self.navigationController pushViewController:check animated:YES];
}

@end
