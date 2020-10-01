//
//  HomeGraphicDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeGraphicDetailVC.h"
#import "HomeGraphicFirstHeader.h"
#import "HomeGraphicFirstFooter.h"
#import "HomeGraphicDetailTableViewCell.h"
//评论
#import "HomeGraphicCommentHeader.h"
#import "HomeGraphicCommentTableViewCell.h"

@interface HomeGraphicDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *gzBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botHeightConst;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@end

@implementation HomeGraphicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    if (IS_IPHONEX) {
        self.botHeightConst.constant += 33;
    }
    self.gzBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#9A9A9A"].CGColor;
    self.gzBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeGraphicDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeGraphicDetailTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeGraphicCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeGraphicCommentTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 + 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 500;
    }
    return 95;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        HomeGraphicFirstHeader *header = [[HomeGraphicFirstHeader alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 500)];
        return header;
    }
    HomeGraphicCommentHeader *header = [[HomeGraphicCommentHeader alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 62)];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 0.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        HomeGraphicFirstFooter *footer = [[HomeGraphicFirstFooter alloc] init];
        return footer;
    }
    UIView *view = [[UIView alloc] init];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(52, 0, ksrcwidth - 52 - 10, 0.5)];
    line.backgroundColor = [UIColor colorWithRGBHex:@"#EFEFEF"];
    [view addSubview:line];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeGraphicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGraphicDetailTableViewCell"];
        return cell;
    }
    HomeGraphicCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGraphicCommentTableViewCell"];
    return cell;
}
@end
