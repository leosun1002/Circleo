//
//  MessageHomeVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageHomeVC.h"
#import "MessageHomeTableViewCell.h"
#import "MessageFansVC.h"
#import "MessageThumsUpVC.h"
#import "MessageCommentsVC.h"
#import "MessageSystemVC.h"
#import "MessageOrderVC.h"
#import "MessageChatVC.h"

@interface MessageHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSIndexPath *editingIndexPath;
@property (weak, nonatomic) IBOutlet UIView *fansView;
@property (weak, nonatomic) IBOutlet UIView *thumbsView;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@end

@implementation MessageHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.tableview registerNib:[UINib nibWithNibName:@"MessageHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageHomeTableViewCell"];
    
    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        MessageFansVC *fans = [[MessageFansVC alloc] init];
        [weakself.navigationController pushViewController:fans animated:YES];
    }];
    [self.fansView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [[tap1 rac_gestureSignal] subscribeNext:^(id x) {
        MessageThumsUpVC *thumbs = [[MessageThumsUpVC alloc] init];
        [weakself.navigationController pushViewController:thumbs animated:YES];
    }];
    [self.thumbsView addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    [[tap2 rac_gestureSignal] subscribeNext:^(id x) {
        MessageCommentsVC *comment = [[MessageCommentsVC alloc] init];
        [weakself.navigationController pushViewController:comment animated:YES];
    }];
    [self.commentView addGestureRecognizer:tap2];
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
        MessageHomeTableViewCell *tableCell = [self.tableview cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews){
            NSLog(@"subview%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 1)
            {
                UIButton *deleteButton = subview.subviews[0];
                deleteButton.tag = self.editingIndexPath.section * 10000 + self.editingIndexPath.row;
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
//        [deleteButton addTarget:self action:@selector(deleteClickWith10:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHomeTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MessageSystemVC *systemVC = [[MessageSystemVC alloc] init];
        [self.navigationController pushViewController:systemVC animated:YES];
    }else if (indexPath.row == 1){
        MessageOrderVC *order = [[MessageOrderVC alloc] init];
        [self.navigationController pushViewController:order animated:YES];
    }else{
        NSString *account = @"s2222222222222222222";
        NIMSession *session = [NIMSession session:account type:(NIMSessionTypeP2P)];
        MessageChatVC *chatVC = [[MessageChatVC alloc] initWithSession:session];
        [self.navigationController pushViewController:chatVC animated:YES];
    }
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
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"   " handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
    }];
    deleteRowAction.image = [UIImage imageNamed:@"msg_delete"];
    deleteRowAction.backgroundColor = [UIColor colorWithRGBHex:@"#FF5C5C"];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}
@end
