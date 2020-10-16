//
//  MineFeedBackVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/16.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineFeedBackVC.h"

@interface MineFeedBackVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UITextView *feedText;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextField *connectText;

@end

@implementation MineFeedBackVC

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
    self.placeLabel.hidden = textView.text.length != 0;
}
@end
