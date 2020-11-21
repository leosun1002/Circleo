//
//  MineDraftsVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/13.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineDraftsVC.h"
#import "MineDraftsTableViewCell.h"

@interface MineDraftsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (assign, nonatomic) BOOL ifEdit;

@end

@implementation MineDraftsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineDraftsTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineDraftsTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    WeakSelf(self);
    [[self.editBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        weakself.ifEdit = !weakself.ifEdit;
        [weakself.editBtn setTitle:weakself.ifEdit?NSLocalizedString(@"完成", nil):NSLocalizedString(@"编辑", nil) forState:(UIControlStateNormal)];
        [weakself.tableview reloadData];
    }];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineDraftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDraftsTableViewCell"];
    cell.addBtn.hidden = !self.ifEdit;
    cell.leadConst.constant = self.ifEdit?60:10;
    cell.trailConst.constant = self.ifEdit?-70:10;
    return cell;
}
@end
