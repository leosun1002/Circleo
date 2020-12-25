
//
//  FindTitleDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/11/20.
//  Copyright © 2020 session. All rights reserved.
//

#import "FindTitleDetailVC.h"

@interface FindTitleDetailVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation FindTitleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightConst.constant = navBarHeight;
    self.titleLabel.text = self.titleStr;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(self.model.link)]]];
    self.descLabel.text = AssectString(self.model.desc);
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
