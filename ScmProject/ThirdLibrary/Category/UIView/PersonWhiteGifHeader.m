//
//  PersonWhiteGifHeader.m
//  ScmProject
//
//  Created by leosun on 2019/11/19.
//  Copyright © 2019 session. All rights reserved.
//

#import "PersonWhiteGifHeader.h"

@implementation PersonWhiteGifHeader

-(void)prepare{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fresh_white%lu",i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    [pullingImages addObject:[UIImage imageNamed:@"fresh_white4"]];
    [self setImages:pullingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 4; i<=24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fresh_white%lu", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];

    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    self.stateLabel.hidden = YES;
}

@end
