//
//  MerchantShopDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/6.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantShopDetailVC.h"

@interface MerchantShopDetailVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addCarBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *topBgview;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;

@end

@implementation MerchantShopDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addBeizierPath];
}

-(void)prepareUi{
    if (@available(iOS 11.0,*)) {
        self.scrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.heightConst.constant = navBarHeight;

    self.addCarBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#CACACA"].CGColor;
    self.addCarBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
    self.addCarBtn.layer.cornerRadius = 18.0f;
    self.addCarBtn.layer.masksToBounds = YES;
    
    //从这里开始就是设置富文本的属性
    NSString *oldPrice = @"＄299.9";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    //下面开始是设置线条的风格：
    //第一个参数addAttribute:是设置要中线（删除线）还是下划线。
    //NSStrikethroughStyleAttributeName：这种是从文本中间穿过，也就是删除线。
    //NSUnderlineStyleAttributeName：这种是下划线。

    //第二个参数value：是设置线条的风格：虚线，实现，点线......
    //第二参数需要同时设置Pattern和style才能让线条显示。
    //第三个参数range:是设置线条的长度，切记，不能超过字符串的长度，否则会报错。
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:NSMakeRange(0, oldPrice.length)];

    //下列是设置线条的颜色
    //第一个参数就是选择设置中线的颜色还是下划线的颜色，如果上面选择的是中线，这里就要选择中线，否则颜色设置不上去。
    //第二个参数很简单，就是颜色而已。
    //第三个参数：同上。
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRGBHex:@"#999999"] range:NSMakeRange(0, oldPrice.length)];
    [self.oldPriceLabel setAttributedText:attri];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addBeizierPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 153) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth, 153);
    maskLayer.path = path.CGPath;
    self.midView.layer.mask = maskLayer;
}

/**
 上下滚动后调用
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算偏移量
    CGFloat thresholdDistance = 281;
    CGFloat percent = scrollView.contentOffset.y/thresholdDistance;
    percent = MAX(0, MIN(1, percent));
    self.topBgview.alpha = percent;
    [self.backBtn setImage:percent > 0?[UIImage imageNamed:@"back_black"]:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    self.tipLabel.textColor = percent > 0?[UIColor colorWithRGBHex:@"#333333"]:[UIColor whiteColor];
}
@end
