//
//  MerchatHomeVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchatHomeVC.h"
#import "MerchantHomeTableViewCell.h"
#import "MerchantHomeHeader.h"
#import "MerchantSectionHeader.h"
#import "MerchantSelectVC.h"
#import "HomeLocationVC.h"
#import "MerchantSearchResultVC.h"
#import "MerchantDetailVC.h"
#import "MerchantClassifyVC.h"
#import "MerchantAtlasVC.h"

@interface MerchatHomeVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MerchatHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    self.view.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantHomeTableViewCell"];
    
    
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 450)];
    headV.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    
    MerchantHomeHeader *header = [[MerchantHomeHeader alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, 450)];
    WeakSelf(self);
    header.subject = [RACSubject subject];
    [header.subject subscribeNext:^(id x) {
        MerchantClassifyVC *classify = [[MerchantClassifyVC alloc] init];
        [weakself.navigationController pushViewController:classify animated:YES];
    }];
    header.pageSubject = [RACSubject subject];
    [header.pageSubject subscribeNext:^(id x) {
        MerchantAtlasVC *atlasVC = [[MerchantAtlasVC alloc] init];
        [weakself.navigationController pushViewController:atlasVC animated:YES];
    }];
    [headV addSubview:header];
    self.tableview.tableHeaderView = headV;
}

-(void)jumpToSelect{
    MerchantSelectVC *select = [[MerchantSelectVC alloc] init];
    select.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:select animated:NO completion:^{
        
    }];
}

- (IBAction)locationClick:(id)sender {
    HomeLocationVC *location = [[HomeLocationVC alloc] init];
    [self.navigationController pushViewController:location animated:YES];
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MerchantSectionHeader *sectionHeader = [[MerchantSectionHeader alloc] init];
    sectionHeader.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    sectionHeader.subject = [RACSubject subject];
    WeakSelf(self);
    [sectionHeader.subject subscribeNext:^(id x) {
        [weakself jumpToSelect];
    }];
    return sectionHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantHomeTableViewCell"];
    cell.contentView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantDetailVC *detail = [[MerchantDetailVC alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma -mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    MerchantSearchResultVC *result = [[MerchantSearchResultVC alloc] init];
    [self.navigationController pushViewController:result animated:YES];
    return NO;
}
@end
