//
//  HomeLongPressVC.m
//  ScmProject
//
//  Created by leosun on 2020/12/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeLongPressVC.h"

@interface HomeLongPressVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation HomeLongPressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self prepareUi];
}

-(void)prepareUi{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    WeakSelf(self);
    [[tap rac_gestureSignal]subscribeNext:^(id x) {
        [weakself dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
    [self.bgView addGestureRecognizer:tap];
}

- (IBAction)unlikeClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (IBAction)jbClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [self.subject sendNext:@""];
    }];
}

@end
