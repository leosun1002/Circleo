
//
//  MineChangeBackImageVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineChangeBackImageVC.h"

@interface MineChangeBackImageVC ()
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@end

@implementation MineChangeBackImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.saveBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#333333"].CGColor;
    self.saveBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    
    self.changeBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#333333"].CGColor;
    self.changeBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}
@end
