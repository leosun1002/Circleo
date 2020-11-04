//
//  HomeVideoDetailView.m
//  ScmProject
//
//  Created by leosun on 2020/10/27.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeVideoDetailView.h"
#import "UUMarqueeView.h"
#import <YYText.h>

@interface HomeVideoDetailView ()<UUMarqueeViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *marqueeBgView;
@property (nonatomic, strong) UUMarqueeView *marqueeView;
@property (weak, nonatomic) IBOutlet UIView *contentBgview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (nonatomic, strong) YYLabel *tokenLabel;

@end

@implementation HomeVideoDetailView

-(instancetype)init{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HomeVideoDetailView" owner:self options:nil] lastObject];
    if ([super init]) {
        self.frame = CGRectMake(0, 0, ksrcwidth, ksrcheight);
        self.backgroundColor = [UIColor clearColor];
        [self prepareUi];
        [self addMarqueeView];
    }
    return self;
}

- (IBAction)backClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(popBack)]) {
        [self.delegate popBack];
    }
}

- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentsClick)]) {
        [self.delegate commentsClick];
    }
}

-(void)prepareUi{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    WeakSelf(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        if ([weakself.delegate respondsToSelector:@selector(playOrPauseClick)]) {
            [weakself.delegate playOrPauseClick];
        }
    }];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    [self.contentBgview addSubview:self.tokenLabel];
}

- (void)addSeeMoreButtonInLabel:(YYLabel *)label {
    UIFont *font16 = [UIFont systemFontOfSize:16];
    UIFont *fontBold16 = [UIFont boldSystemFontOfSize:16];
    
    label.attributedText = [[NSAttributedString alloc] initWithString:@"在卑尔根北部的盖朗厄尔峡湾网红悬崖 打卡点，长15公里，两岸耸立..." attributes:@{NSFontAttributeName : font16,NSForegroundColorAttributeName:[UIColor whiteColor]}];
 
    NSString *moreString = @" 展开";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"... %@", moreString]];
    NSRange expandRange = [text.string rangeOfString:moreString];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:expandRange];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, expandRange.location)];

    //添加点击事件
    YYTextHighlight *hi = [YYTextHighlight new];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:moreString]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击展开
        [weakSelf setContentFrame:YES];
    };
    
    text.yy_font = fontBold16;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentTop];
    
    label.truncationToken = truncationToken;

}

- (NSAttributedString *)appendAttriStringWithFont:(UIFont *)font {
    if (!font) {
        font = [UIFont systemFontOfSize:16];
    }
    if ([_tokenLabel.attributedText.string containsString:@"收起"]) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
 
    
    NSString *appendText = @" 收起 ";
    NSMutableAttributedString *append = [[NSMutableAttributedString alloc] initWithString:appendText attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [append yy_setTextHighlight:hi range:[append.string rangeOfString:appendText]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击收起
        [weakSelf setContentFrame:NO];
    };
    
    return append;
}
 
- (void)expandString {
    NSMutableAttributedString *attri = [_tokenLabel.attributedText mutableCopy];
    [attri appendAttributedString:[self appendAttriStringWithFont:attri.yy_font]];
    _tokenLabel.attributedText = attri;
}
 
- (void)packUpString {
    NSString *appendText = @" 收起 ";
    NSMutableAttributedString *attri = [_tokenLabel.attributedText mutableCopy];
    NSRange range = [attri.string rangeOfString:appendText options:NSBackwardsSearch];
 
    if (range.location != NSNotFound) {
        [attri deleteCharactersInRange:range];
    }
 
    _tokenLabel.attributedText = attri;
}
 
 
- (void)setContentFrame:(BOOL)isExpand {
    if (isExpand) {
        [self expandString];
        self.tokenLabel.frame = CGRectMake(0, 0, 254, 80);
        self.contentHeight.constant = 80;
    } else {
        [self packUpString];
        self.tokenLabel.frame = CGRectMake(0, 0, 254, 50);
        self.contentHeight.constant = 50;
    }
    [self layoutIfNeeded];
}

-(void)addMarqueeView{
    self.marqueeView = [[UUMarqueeView alloc] initWithFrame:CGRectMake(0, 0, 100, 20) direction:(UUMarqueeViewDirectionLeftward)];
    self.marqueeView.delegate = self;
    self.marqueeView.timeIntervalPerScroll = 3.f;
    self.marqueeView.timeDurationPerScroll = 0.2f;
    self.marqueeView.touchEnabled = YES;
    [self.marqueeBgView addSubview:self.marqueeView];
    
    [self.marqueeView reloadData];
}

#pragma mark - UUMarqueeViewDelegate
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView*)marqueeView {
    return 1;
}

- (NSUInteger)numberOfDataForMarqueeView:(UUMarqueeView*)marqueeView {
    return 1;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(UUMarqueeView*)marqueeView {
    // for upwardMultiMarqueeView
    itemView.backgroundColor = [UIColor clearColor];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, marqueeView.width, marqueeView.height)];
    content.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    content.textColor = [UIColor whiteColor];
    content.text = @"Only Time-Enya";
    [itemView addSubview:content];
}

- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // for upwardMultiMarqueeView
}

- (CGFloat)itemViewHeightAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // for upwardDynamicHeightMarqueeView
    return marqueeView.height;
}

- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // for leftwardMarqueeView
    return marqueeView.width;
}

- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
}

#pragma mark -  UIGestureRecognizer Delegate
//解决TabView与Tap手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YYLabel"]) {
        return NO;
    }
    return  YES;
}

#pragma -mark getter
- (YYLabel *)tokenLabel {
    if (!_tokenLabel) {
        _tokenLabel = [YYLabel new];
        _tokenLabel.frame = CGRectMake(0, 0, 254, 50);
        self.contentHeight.constant = 50;
        _tokenLabel.numberOfLines = 0;
        _tokenLabel.backgroundColor = [UIColor clearColor];
        [self addSeeMoreButtonInLabel:_tokenLabel];
    }
    return _tokenLabel;
}

@end
