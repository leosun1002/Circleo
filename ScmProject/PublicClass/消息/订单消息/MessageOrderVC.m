//
//  MessageOrderVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageOrderVC.h"
#import "MessageOrderTableViewCell.h"
#import "OrderModel.h"

@interface MessageOrderVC ()<UITableViewDataSource,UITableViewDelegate>{
    int page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property(nonatomic,strong)NSIndexPath *editingIndexPath;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation MessageOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addRefresh];
    [self.tableview.mj_header beginRefreshing];

}

#pragma mark - viewDidLayoutSubviews
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath){
        [self configSwipeButtons];
    }
}
 
#pragma mark - configSwipeButtons
- (void)configSwipeButtons{
    // 获取选项按钮的reference
    if (@available(iOS 11.0, *)){
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.tableview.subviews)
        {
            NSLog(@"%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 1)
            {
                // 和iOS 10的按钮顺序相反
            }
        }
    } else{
        // iOS 8-10层级 (Xcode 8编译): UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        MessageOrderTableViewCell *tableCell = [self.tableview cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews){
            NSLog(@"subview%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 1)
            {
                UIButton *deleteButton = subview.subviews[0];
                deleteButton.tag = self.editingIndexPath.row;
                [self configDeleteButton:deleteButton];
            }
        }
    }
}

- (void)configDeleteButton:(UIButton*)deleteButton{
    if (deleteButton) {
        [deleteButton setImage:[UIImage imageNamed:@"msg_delete"] forState:UIControlStateNormal];
        [deleteButton setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        deleteButton.backgroundColor = [UIColor colorWithRGBHex:@"#FF5C5C"];
        [deleteButton addTarget:self action:@selector(delateClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    [self.tableview registerNib:[UINib nibWithNibName:@"MessageOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageOrderTableViewCell"];
    self.tableview.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
}

-(void)addRefresh{
    WeakSelf(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getFansData:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getFansData:NO];
    }];
}

-(void)getFansData:(BOOL)ifFresh{
    ifFresh?(page = 1):page++;
    WeakSelf(self);
    NSDictionary *dict = @{
        @"pageNo": [NSString stringWithFormat:@"%d",page],
      @"pageSize": PageSize,
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    [WebServices postWithUrl:@"news/newsorders/" body:dict loadingTime:12.f showLoading:NO success:^(NSDictionary *response) {
        ifFresh?[weakself.datas removeAllObjects]:nil;
        NSMutableArray<OrderModel*> *applicationList = [OrderModel mj_objectArrayWithKeyValuesArray:response[resultData]];
        [weakself.datas addObjectsFromArray:applicationList];
        [weakself.tableview reloadData];
    } failure:^(NSError *error) {
    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

#pragma -mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageOrderTableViewCell"];
    OrderModel *model = self.datas[indexPath.row];
    [cell.headV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.businessImg)]]];
    cell.dateTimeLabel.text = AssectString(model.createDate);
    //1订单支付成功提醒 2订单使用提醒 3订单退款提醒 4退款申请通过提醒 5退货退款申请通过提醒 6订单预约成功提醒
    switch ([model.flag intValue]) {
        case 1:
        {
            cell.nameLabel.text = NSLocalizedString(@"订单支付成功提醒", nil);
            cell.contentLabel.text = NSLocalizedString(@"您的订单已经成功支付啦~记得在有效时间内使用 哦~点击查看详情", nil);
            break;
        }
        case 2:
        {
            cell.nameLabel.text = NSLocalizedString(@"订单使用提醒", nil);
            cell.contentLabel.text = NSLocalizedString(@"您的订单已经使用成功啦~记得去评价哦~点击查看 详情", nil);
            break;
        }
        case 3:
        {
            cell.nameLabel.text = NSLocalizedString(@"退款提醒", nil);
            cell.contentLabel.text = NSLocalizedString(@"您的订单已经退款成功,点击查看详情", nil);
            break;
        }
        case 4:
        {
            cell.nameLabel.text = NSLocalizedString(@"退款申请通过提醒", nil);
            cell.contentLabel.text = NSLocalizedString(@"您的订单退款申请已经通过,点击查看详情", nil);
            break;
        }
        case 5:
        {
            cell.nameLabel.text = NSLocalizedString(@"退货退款申请通过提醒", nil);
            cell.contentLabel.text = NSLocalizedString(@"您的订单退货退款申请已经通过,点击查看详情", nil);
            break;
        }
        case 6:
        {
            cell.nameLabel.text = NSLocalizedString(@"订单预约成功提醒", nil);
            cell.contentLabel.text = NSLocalizedString(@"您的订单已经预约成功,点击查看详情", nil);
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editingIndexPath = nil;
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //title不设为nil 而是空字符串 理由为啥 ？   自己实践 跑到ios11以下的机器上就知道为啥了
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"   " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSLog(@"asd");

        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
    }];
    deleteAction.backgroundColor = [UIColor whiteColor];
    
    return @[deleteAction];
}

//iOS11 后的新方法,,  可以设置image和title
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    WeakSelf(self);
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"   " handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [weakself delateClick2:indexPath.row];

        completionHandler (YES);
    }];
    deleteRowAction.image = [UIImage imageNamed:@"msg_delete"];
    deleteRowAction.backgroundColor = [UIColor colorWithRGBHex:@"#FF5C5C"];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

-(void)delateClick:(UIButton *)sender{
    OrderModel *model = self.datas[sender.tag];
    [self deletaData:AssectString(model.mainid)];
}

-(void)delateClick2:(NSInteger)row{
    OrderModel *model = self.datas[row];
   [self deletaData:AssectString(model.mainid)];
}

-(void)deletaData:(NSString *)mainid{
    NSDictionary *dict = @{
      @"id": mainid
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"news/newsordersdel/" body:dict loadingTime:12.f showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            [weakself.tableview.mj_header beginRefreshing];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

- (IBAction)clearAllClick:(id)sender {
    NSDictionary *dict = @{
      @"userId": [Manager takeoutUserTokenkey:Loginuser].userId
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"news/newsordersclear/" body:dict loadingTime:12.f showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            [weakself.tableview.mj_header beginRefreshing];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}


#pragma -mark getter
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
