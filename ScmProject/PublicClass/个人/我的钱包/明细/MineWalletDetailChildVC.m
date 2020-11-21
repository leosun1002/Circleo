//
//  MineWalletDetailChildVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineWalletDetailChildVC.h"
#import "MineWalletDetailTableViewCell.h"
#import <BRPickerView.h>

@interface MineWalletDetailChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *fromView;
@property (weak, nonatomic) IBOutlet UIView *toView;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;

@end

@implementation MineWalletDetailChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineWalletDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineWalletDetailTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];

    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [weakself selectDate:@"from"];
    }];
    [self.fromView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [[tap1 rac_gestureSignal] subscribeNext:^(id x) {
        [weakself selectDate:@"to"];
    }];
    [self.toView addGestureRecognizer:tap1];
}

-(void)selectDate:(NSString *)fromStr{
    WeakSelf(self);
    [BRDatePickerView showDatePickerWithMode:(BRDatePickerModeDate) title:NSLocalizedString(@"请选择选择日期", nil) selectValue:@"" resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        if ([fromStr isEqualToString:@"from"]) {
            weakself.fromDateLabel.text = selectValue;
        }else{
            weakself.toDateLabel.text = selectValue;
        }
    }];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineWalletDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineWalletDetailTableViewCell"];
    return cell;
}

@end
