//
//  MerchantClassifyVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/5.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantClassifyVC.h"
#import "MerchantHomeTableViewCell.h"
#import "MerchantClassifySelectVC.h"

@interface MerchantClassifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIView *allView;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UIView *seqView;

@end

@implementation MerchantClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantHomeTableViewCell"];
    
    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        MerchantClassifySelectVC *select = [[MerchantClassifySelectVC alloc] init];
        select.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [weakself presentViewController:select animated:NO completion:^{
            
        }];
    }];
    [self.allView addGestureRecognizer:tap];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantHomeTableViewCell"];
    cell.contentView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    return cell;
}

@end
