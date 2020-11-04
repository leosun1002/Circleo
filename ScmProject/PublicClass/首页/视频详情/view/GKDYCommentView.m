//
//  GKDYCommentView.m
//  GKDYVideo
//
//  Created by QuintGao on 2019/5/1.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "GKDYCommentView.h"
#import "HomeGraphicCommentTableViewCell.h"
#import "HomeGraphicCommentHeader.h"

@interface GKDYCommentView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIView                *topView;
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, assign) NSInteger             count;
@end

@implementation GKDYCommentView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self addTopView];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)requestData {
}

-(void)addTopView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 30)];
    topView.backgroundColor = [UIColor whiteColor];
     
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ksrcwidth - 30, 13)];
    countLabel.text = @"共 2623 条评论";
    countLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    countLabel.textColor = [UIColor colorWithRGBHex:@"#333333"];
    [topView addSubview:countLabel];
    [self addSubview:_topView = topView];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 30) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = topView.bounds;
    maskLayer.path = path1.CGPath;
    topView.layer.mask = maskLayer;
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 95;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeGraphicCommentHeader *header = [[HomeGraphicCommentHeader alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 62)];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(52, 0, ksrcwidth - 52 - 10, 0.5)];
    line.backgroundColor = [UIColor colorWithRGBHex:@"#EFEFEF"];
    [view addSubview:line];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeGraphicCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGraphicCommentTableViewCell"];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ksrcwidth, 470 - CGRectGetMaxY(self.topView.frame)) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"HomeGraphicCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeGraphicCommentTableViewCell"];
    }
    return _tableView;
}

@end
