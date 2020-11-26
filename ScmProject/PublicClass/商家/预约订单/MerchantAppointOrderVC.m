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
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

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
        [weakself makeBtnEnable];
    }];
    [[self.nameText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself makeBtnEnable];
    }];
    [[self.phoneText rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        [weakself makeBtnEnable];
    }];
}

-(void)makeBtnEnable{
    NSString *timeStr = self.timeText.text;
    NSString *nameStr = self.nameText.text;
    NSString *phoneStr = self.phoneText.text;
    if (![AssectString(timeStr) isEqualToString:@""] && ![AssectString(nameStr) isEqualToString:@""] && ![AssectString(phoneStr) isEqualToString:@""]) {
        self.checkBtn.userInteractionEnabled = YES;
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#333333"];
    }else{
        self.checkBtn.userInteractionEnabled = NO;
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#C0C0CC"];
    }
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
