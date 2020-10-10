//
//  MineOrderEvaluateDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderEvaluateDetailVC.h"
#import "CWStarRateView.h"
#import "MineApplyRefundCollectionViewCell.h"

#define MaxLimit 200

@interface MineOrderEvaluateDetailVC ()<CWStarRateViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *starBgview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectHeight;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextView *evaText;

@end

@implementation MineOrderEvaluateDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    [self addStarView];
    [self addCollect];
}

-(void)addStarView{
    CWStarRateView *rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(52, 15, 160, 20) numberOfStars:5];
    rateView.hasAnimation = YES;
    rateView.scorePercent = 0.2;
    rateView.isTap = YES;
    rateView.delegate = self;
    [self.starBgview addSubview:rateView];
}

-(void)addCollect{
    CGFloat width = (ksrcwidth - 40)/3;
    self.flowLayout.itemSize = CGSizeMake(width,width);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"MineApplyRefundCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MineApplyRefundCollectionViewCell"];
    self.collectHeight.constant = width*2;
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineApplyRefundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineApplyRefundCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma -mark CWStarRateViewDelegate
-(void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSString *lang = [[textView textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (textView.text.length > MaxLimit) {
                textView.text = [textView.text substringToIndex:MaxLimit];
                [self showMsg:NSLocalizedString(@"最多显示200字", nil) location:centre];
            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (textView.text.length > MaxLimit) {
            textView.text = [textView.text substringToIndex:MaxLimit];
            [self showMsg:NSLocalizedString(@"最多显示200字", nil) location:centre];
        }
    }
    self.placeLabel.hidden = textView.text.length != 0;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self isText:textView beyondLimit:MaxLimit] && [text length] > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isText:(UITextView *)tv beyondLimit:(int)maxLimit{
    NSString *lang = [[tv textInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [tv markedTextRange];
        UITextPosition *position = [tv positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (tv.text.length > maxLimit) {
                return YES;
            }
        }
    } else {
        if (tv.text.length > maxLimit) {
            return YES;
        }
    }
    return NO;
}
@end
