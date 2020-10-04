//
//  MerchantSelectVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantSelectVC.h"
#import "MerchantSelectTableViewCell.h"

@interface MerchantSelectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heigtConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@end

@implementation MerchantSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addBeizierPath];
}

-(void)prepareUi{
    self.heigtConst.constant = statusHeight;
    self.view.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantSelectTableViewCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    WeakSelf(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [weakself dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
    [weakself.bgView addGestureRecognizer:tap];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakself.tableHeight.constant = 200;
        [UIView animateWithDuration:0.25 animations:^{
           [weakself.view layoutIfNeeded];
        }];
    });
}

-(void)addBeizierPath{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 200) byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth, 200);
    maskLayer.path = path1.CGPath;
    self.tableview.layer.mask = maskLayer;
}

#pragma -mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantSelectTableViewCell"];
    return cell;
}

@end
