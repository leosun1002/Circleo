//
//  MerchantClassifySelectVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/5.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantClassifySelectVC.h"
#import "MerchantSelectTableViewCell.h"

@interface MerchantClassifySelectVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@end

@implementation MerchantClassifySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addBeizierPath];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    self.view.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantSelectTableViewCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    WeakSelf(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [weakself dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
    [weakself.bgview addGestureRecognizer:tap];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakself.tableHeight.constant = 250;
        [UIView animateWithDuration:0.25 animations:^{
           [weakself.view layoutIfNeeded];
        }];
    });
}

-(void)addBeizierPath{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 250) byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth, 250);
    maskLayer.path = path1.CGPath;
    self.tableview.layer.mask = maskLayer;
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantSelectTableViewCell"];
    return cell;
}

@end
