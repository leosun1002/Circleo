//
//  MerchantDetailHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/4.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantDetailHeader.h"
#import "SDCycleScrollView.h"

@interface MerchantDetailHeader ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *scrollBgview;
@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation MerchantDetailHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantDetailHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self addScrollView];
    }
    return self;
}

-(void)addScrollView{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ksrcwidth, 280) delegate:self placeholderImage:[UIColor createColorImg:@"#FFFFFF"]];
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    cycleScrollView.showPageControl = NO;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"dot_bg_select"];
    cycleScrollView.autoScrollTimeInterval = 3.f;
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"dot_bg_unselect"];
    cycleScrollView.pageControlDotSize = CGSizeMake(4.f, 4.f);
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.layer.masksToBounds = YES;
    cycleScrollView.layer.cornerRadius = 10;
    [self.scrollBgview addSubview:_cycleScrollView = cycleScrollView];

    self.scrollBgview.layer.cornerRadius = 10;
    [self.scrollBgview bringSubviewToFront:self.pageView];
    
    self.tipLabel.layer.borderColor = [UIColor colorWithRGBHex:@"#CACACA"].CGColor;
    self.tipLabel.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}
@end
