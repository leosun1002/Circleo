//
//  MineSetPhoneMailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineSetPhoneMailVC.h"
#import "MineBindPhoneMailVC.h"

@interface MineSetPhoneMailVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCosnt;

@end

@implementation MineSetPhoneMailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)bindClick:(id)sender {
    MineBindPhoneMailVC *bindMail = [[MineBindPhoneMailVC alloc] init];
    [self.navigationController pushViewController:bindMail animated:YES];
}

-(void)prepareUi{
    self.heightCosnt.constant = navBarHeight;
}
@end
