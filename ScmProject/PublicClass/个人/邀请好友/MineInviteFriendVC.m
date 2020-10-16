//
//  MineInviteFriendVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/13.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineInviteFriendVC.h"

@interface MineInviteFriendVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;

@end

@implementation MineInviteFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.imgBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.imgBtn.layer.borderWidth = [[UIScreen mainScreen] scale] * 0.5;
}
@end
