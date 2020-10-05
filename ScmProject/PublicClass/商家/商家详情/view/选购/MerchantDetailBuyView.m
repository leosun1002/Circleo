//
//  MerchantDetailBuyView.m
//  ScmProject
//
//  Created by leosun on 2020/10/4.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantDetailBuyView.h"
#import "MerchantBuyLeftTableViewCell.h"
#import "MerchantBuyRightTableViewCell.h"

@interface MerchantDetailBuyView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;

@end

@implementation MerchantDetailBuyView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantDetailBuyView" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        self.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
        [self preapreUi];
    }
    return self;
}

-(void)preapreUi{
    [self.leftTable registerNib:[UINib nibWithNibName:@"MerchantBuyLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantBuyLeftTableViewCell"];
    [self.rightTable registerNib:[UINib nibWithNibName:@"MerchantBuyRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"MerchantBuyRightTableViewCell"];
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        MerchantBuyLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantBuyLeftTableViewCell"];
        return cell;
    }else{
        MerchantBuyRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantBuyRightTableViewCell"];
        return cell;
    }
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
