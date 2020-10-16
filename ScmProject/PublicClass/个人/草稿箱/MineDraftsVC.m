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
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineDraftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDraftsTableViewCell"];
    return cell;
}
@end
