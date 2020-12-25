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

//键盘
#import "STEmojiKeyboard.h"

#define kSTTextviewMaxHeight 120
#define kSTTextviewDefaultHeight 36

@interface GKDYCommentView()<UITextViewDelegate>{
    NSArray *_switchKeyboardImages;

}

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, assign) NSInteger count;
@property (strong, nonatomic) STEmojiKeyboard *keyboard;

//输入框高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (weak, nonatomic) IBOutlet UITextView *inputText;

//评论
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeigth;

//键盘图标
@property (weak, nonatomic) IBOutlet UIButton *keyboardBtn;

//占位Label
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

//收藏背景
@property (weak, nonatomic) IBOutlet UIView *sendView;
//总底部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;

@end

@implementation GKDYCommentView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"GKDYCommentView" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        self.backgroundColor = [UIColor clearColor];
        [self prepareUi];
        //注册键盘
        [self registerKeyboardNotif];
    }
    return self;
}

- (void)requestData {
}

-(void)prepareUi{
    [self bringSubviewToFront:self.bottomView];
    self.keyboard = [STEmojiKeyboard keyboard];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 45) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth, 45);
    maskLayer.path = path1.CGPath;
    self.topView.layer.mask = maskLayer;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeGraphicCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeGraphicCommentTableViewCell"];

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

#pragma -mark 监听键盘
- (void)keyboardWillShow:(NSNotification *)notification{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;   //height 就是键盘的高度
    self.bottomConst.constant = height;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    self.inputText.text = @"";
    [self layout];
    self.bottomConst.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
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

#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView{
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
@end
