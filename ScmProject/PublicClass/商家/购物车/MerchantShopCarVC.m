//
//  MerchantShopCarVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/5.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantShopCarVC.h"
#import "MerchantShopCarTableViewCell.h"

@interface MerchantShopCarVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;

@end

@implementation MerchantShopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.view.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantShopCarTableViewCell"];
    
    WeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakself.bottomConst.constant = 10;
        [UIView animateWithDuration:0.25 animations:^{
            [weakself.view layoutIfNeeded];
        }];
    });
}

- (IBAction)closeClick:(id)sender {
    self.bottomConst.constant = -440;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}

#pragma -mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantShopCarTableViewCell"];
    return cell;
}

@end
