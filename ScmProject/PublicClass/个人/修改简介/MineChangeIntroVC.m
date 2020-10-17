//
//  MineChangeIntroVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/17.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineChangeIntroVC.h"
#define MaxLimit 50

@interface MineChangeIntroVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextView *introText;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation MineChangeIntroVC

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

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSString *lang = [[textView textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (textView.text.length > MaxLimit) {
                textView.text = [textView.text substringToIndex:MaxLimit];
                [self showMsg:NSLocalizedString(@"超出字数限制", nil) location:centre];
            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (textView.text.length > MaxLimit) {
            textView.text = [textView.text substringToIndex:MaxLimit];
            [self showMsg:NSLocalizedString(@"超出字数限制", nil) location:centre];
        }
    }
    [self updateRemainCount];
    self.placeLabel.hidden = textView.text.length != 0;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self isText:textView beyondLimit:MaxLimit] && [text length] > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isText:(UITextView *)tv beyondLimit:(int)maxLimit{
    NSString *lang = [[tv textInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [tv markedTextRange];
        UITextPosition *position = [tv positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (tv.text.length > maxLimit) {
                return YES;
            }
        }
    } else {
        if (tv.text.length > maxLimit) {
            return YES;
        }
    }
    return NO;
}

- (void)updateRemainCount {
    self.remarkLabel.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)self.introText.text.length];
}
@end
