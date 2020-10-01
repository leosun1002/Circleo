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

#import "STInputBar.h"
#import <IQKeyboardManager.h>
#import "STEmojiKeyboard.h"

#define kSTTextviewMaxHeight 120
#define kSTTextviewDefaultHeight 36


@interface HomeGraphicDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_switchKeyboardImages;

}

@property (weak, nonatomic) IBOutlet UIButton *gzBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextView *inputText;
@property (strong, nonatomic) STEmojiKeyboard *keyboard;
//输入框高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;

//评论
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeigth;

//键盘图标
@property (weak, nonatomic) IBOutlet UIButton *keyboardBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoradWidth;

//占位Label
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

//收藏背景
@property (weak, nonatomic) IBOutlet UIView *collectBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectWidth;
@property (weak, nonatomic) IBOutlet UIView *sendView;
//总底部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@end

@implementation HomeGraphicDetailVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareUi];
    //注册键盘
    [self registerKeyboardNotif];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.keyboard = [STEmojiKeyboard keyboard];

    self.gzBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#9A9A9A"].CGColor;
    self.gzBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeGraphicDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeGraphicDetailTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeGraphicCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeGraphicCommentTableViewCell"];
    //设置评论框旁的视图宽度
    self.collectWidth.constant = ksrcwidth - 150 - 10 - 30;
    
    //发送按钮
    self.sendView.layer.shadowColor = [UIColor colorWithRGBHex:@"#090000"].CGColor;//阴影颜色
    self.sendView.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
    self.sendView.layer.shadowOpacity = 0.2f;//不透明度
    self.sendView.layer.shadowRadius = 5;//半径
    
    _switchKeyboardImages = @[@"btn_expression.png",@"btn_keyboard.png"];
}

- (void)registerKeyboardNotif{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)switchClick:(UIButton *)button {
    if (button.tag == 1){
        self.inputText.inputView = nil;
    }
    else{
        [_keyboard setTextView:self.inputText];
    }
    [self.inputText reloadInputViews];
    [self.inputText becomeFirstResponder];
    button.tag = (button.tag+1)%2;
    [button setImage:[UIImage imageNamed:_switchKeyboardImages[button.tag]] forState:UIControlStateNormal];

}

-(void)layout{
    self.placeLabel.hidden = ![@"" isEqualToString:self.inputText.text];

    CGRect textViewFrame = self.inputText.frame;
    CGSize textSize = [self.inputText sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    
    CGFloat offset = 0;
    self.inputText.scrollEnabled = (textSize.height > kSTTextviewMaxHeight-offset);
    CGFloat height = MAX(kSTTextviewDefaultHeight, MIN(kSTTextviewMaxHeight, textSize.height));
    self.inputHeight.constant = height;
    self.commentHeigth.constant = height;
    self.bottomViewHeight.constant = height + 24.5;
}

- (IBAction)sendClick:(id)sender {
    self.inputText.text = @"";
    [self layout];
    [self.view endEditing:YES];
}

#pragma -mark 监听键盘
- (void)keyboardWillShow:(NSNotification *)notification
{
    self.commentWidth.constant = ksrcwidth - 35 - 60;
    self.collectBgView.hidden = YES;
    self.sendView.hidden = NO;
    self.keyboardBtn.hidden = NO;
    self.keyBoradWidth.constant = 20;
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    self.commentWidth.constant = 150;
    self.collectBgView.hidden = NO;
    self.sendView.hidden = YES;
    self.keyboardBtn.hidden = YES;
    self.keyBoradWidth.constant = 0;
    
    self.inputText.text = @"";
    [self layout];
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


#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView{
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
@end
