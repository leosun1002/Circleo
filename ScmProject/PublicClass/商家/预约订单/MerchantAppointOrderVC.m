//
//  MerchantAppointOrderVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantAppointOrderVC.h"
#import <BRPickerView.h>

@interface MerchantAppointOrderVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextField *timeText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation MerchantAppointOrderVC

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

-(void)timeSelect{
    WeakSelf(self);
    [BRDatePickerView showDatePickerWithMode:(BRDatePickerModeYMDHMS) title:NSLocalizedString(@"选择日期", nil) selectValue:self.timeText.text resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        weakself.timeText.text = selectValue;
    }];
}

#pragma -mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.timeText) {
        [self timeSelect];
        return NO;
    }
    return YES;
}

@end
