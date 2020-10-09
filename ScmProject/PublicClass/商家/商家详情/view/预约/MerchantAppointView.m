//
//  MerchantAppointView.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantAppointView.h"
#import "MerchantAppointTableViewCell.h"
#import "MerchantAppointOrderVC.h"

@interface MerchantAppointView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MerchantAppointView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantAppointView" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        self.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
        [self preapreUi];
    }
    return self;
}

-(void)preapreUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MerchantAppointTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantAppointTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantAppointTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantAppointOrderVC *appoint = [[MerchantAppointOrderVC alloc] init];
    [self.navigation pushViewController:appoint animated:YES];
}

#pragma -mark JXPagerViewListViewDelegate
- (UIScrollView *)listScrollView {
    return nil;
}

- (UIView *)listView {
    return self;
}

// 必须加（用于联动）
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
@end
