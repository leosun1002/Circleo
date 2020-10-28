//
//  HomeVideoDetailView.m
//  ScmProject
//
//  Created by leosun on 2020/10/27.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeVideoDetailView.h"

@interface HomeVideoDetailView ()

@end

@implementation HomeVideoDetailView

-(instancetype)init{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HomeVideoDetailView" owner:self options:nil] lastObject];
    if ([super init]) {
        self.frame = CGRectMake(0, 0, ksrcwidth, ksrcheight);
        self.backgroundColor = [UIColor clearColor];
        [self prepareUi];
    }
    return self;
}

- (IBAction)backClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(popBack)]) {
        [self.delegate popBack];
    }
}

-(void)prepareUi{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    WeakSelf(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        if ([weakself.delegate respondsToSelector:@selector(playOrPauseClick)]) {
            [self.delegate playOrPauseClick];
        }
    }];
    [self addGestureRecognizer:tap];
}

@end
