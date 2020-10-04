//
//  MerchantSectionHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantSectionHeader.h"

@implementation MerchantSectionHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MerchantSectionHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self prepareUi];
    }
    return self;
}

-(void)prepareUi{
    WeakSelf(self);
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [[tap1 rac_gestureSignal] subscribeNext:^(id x) {
        [weakself.subject sendNext:@""];
    }];
    [self.areaView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    [[tap2 rac_gestureSignal] subscribeNext:^(id x) {
        [weakself.subject sendNext:@""];
    }];
    [self.seqView addGestureRecognizer:tap2];
}
@end
