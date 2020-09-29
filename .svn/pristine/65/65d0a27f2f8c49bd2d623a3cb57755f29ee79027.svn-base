//
//  BHBCenterView.m
//  BHBPopViewDemo
//
//  Created by 毕洪博 on 15/8/15.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "BHBCenterView.h"
#import "BHBCustomBtn.h"
#import "UIButton+BHBSetImage.h"
#import "BHBItem.h"
#import "UIView+BHBAnimation.h"
#import "BHBGroup.h"

#define ksrcwidth [UIScreen mainScreen].bounds.size.width
#define BHButtonWidth (ksrcwidth - 30)/4
#define BHButtonEdge 5

@interface BHBCenterView ()

@property (nonatomic,strong) NSMutableArray * visableBtnArray;
@property (nonatomic,strong) NSMutableArray * homeBtns;
@property (nonatomic,strong) NSMutableArray * moreBtns;
@property (nonatomic,strong) BHBGroup * currentGroup;
@property (nonatomic,assign) BOOL btnCanceled;

@end

@implementation BHBCenterView
@dynamic delegate;

-(NSMutableArray *)homeBtns
{
    if (!_homeBtns) {
        _homeBtns = [NSMutableArray array];
    }
    return _homeBtns;
}

-(NSMutableArray *)visableBtnArray
{
    if (!_visableBtnArray) {
        _visableBtnArray = [NSMutableArray array];
    }
    return _visableBtnArray;
}

- (NSMutableArray *)moreBtns{
    if (!_moreBtns) {
        _moreBtns = [[NSMutableArray alloc] init];
    }
    return _moreBtns;
}

- (void)reloadData{
    //    NSAssert(self.delegate, @"BHBCenterView`s delegate was nil.");
    NSAssert(self.dataSource, @"BHBCenterView`s dataSource was nil.");
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsWithCenterView:)], @"BHBCenterView`s was unimplementation numberOfItemsWithCenterView:.");
    NSAssert([self.dataSource respondsToSelector:@selector(itemWithCenterView:item:)], @"BHBCenterView`s was unimplementation itemWithCenterView:item:.");
    [self.homeBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.moreBtns makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.homeBtns removeAllObjects];
    [self.moreBtns removeAllObjects];
    NSUInteger count = [self.dataSource numberOfItemsWithCenterView:self];
    NSMutableArray * items = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        [items addObject:[self.dataSource itemWithCenterView:self item:i]];
    }
    [self layoutBtnsWith:items isMore:NO];
    [self btnPositonAnimation:NO];
}

- (void)layoutBtnsWith:(NSArray *)items isMore:(BOOL)isMore{
    if(isMore){
        [self.moreBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.moreBtns removeAllObjects];
    }
    BHBItem * item;
    for (int i = 0; i < items.count; i ++) {
        item = items[i];
        BHBCustomBtn * btn = [BHBCustomBtn buttonWithType:UIButtonTypeCustom];
//        [btn setImage:[UIImage imageNamed:@"item.icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeCenter];
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        CGFloat x = i>3 ?(i - 4) * BHButtonWidth:BHButtonWidth * i ;
        CGFloat y = i>3 ? BHButtonWidth + BHButtonEdge:0;
        if (isMore) {
            x += [UIScreen mainScreen].bounds.size.width;
            [self.moreBtns addObject:btn];
        }
        else {
            [self.homeBtns addObject:btn];
        }
        CGFloat width = BHButtonWidth;
        CGFloat height = BHButtonWidth;
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.frame = CGRectMake(x, y, width, height);
    }
}

- (void)didTouchBtn:(BHBCustomBtn *)btn{
    [btn scalingWithTime:.15 andscal:1.2];
}

- (void)didCancelBtn:(BHBCustomBtn *)btn{
    self.btnCanceled = YES;
    [btn scalingWithTime:.15 andscal:1];
}

- (void)scrollBack{
    [self.visableBtnArray removeAllObjects];
    [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.visableBtnArray addObject:obj];
    }];
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)didClickBtn:(BHBCustomBtn *)btn{
    if (self.btnCanceled) {
        self.btnCanceled = NO;
        return;
    }
    
    BHBItem * item;
    NSInteger index;
    if([self.homeBtns containsObject:btn]){
        index = [self.homeBtns indexOfObject:btn];
        item = [self.dataSource itemWithCenterView:self item:index];
    }
    if ([self.moreBtns containsObject:btn]) {
        index = [self.moreBtns indexOfObject:btn];
        item = [self.currentGroup.items objectAtIndex:index];
    }
    [btn scalingWithTime:.25 andscal:1];
    if([item isKindOfClass:[BHBGroup class]]){
        BHBGroup * group = (BHBGroup *)item;
        self.currentGroup = group;
        if (!self.delegate || ![self.delegate respondsToSelector:@selector(didSelectMoreWithCenterView:andItem:)]) {
            return;
        }
        [self layoutBtnsWith:group.items isMore:YES];
        [self.visableBtnArray removeAllObjects];
        [self.moreBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.visableBtnArray addObject:obj];
        }];
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
        [self.delegate didSelectMoreWithCenterView:self andItem:group];
        return;
    }
    else{
        if (!self.delegate || ![self.delegate respondsToSelector:@selector(didSelectItemWithCenterView:andIndex:)]) {
            return;
        }
        [self.delegate didSelectItemWithCenterView:self andIndex:index];
    }
}

- (void)dismis{
    [self btnPositonAnimation:YES];
}

- (void)removeAnimation:(NSInteger)index{
    [self.visableBtnArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BHBCustomBtn * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        __weak typeof(self) weakself = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.visableBtnArray.count - idx) * 0.08 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [UIView animateWithDuration:0.5 animations:^{
                 btn.alpha = 0;
             } completion:^(BOOL finished) {
                 if ([btn isEqual:[weakself.visableBtnArray lastObject]]) {
                     weakself.superview.superview.userInteractionEnabled = YES;
                 }
             }];
            
            CASpringAnimation *sp = [CASpringAnimation animationWithKeyPath:@"position"];
            sp.mass = 0.4;//质量，影响图层运动时的弹簧惯性,质量越大，弹簧拉伸和压缩的幅度越大,默认1
            sp.stiffness = 100.0f;//弹性系数，弹性系数越大，形变产生的力就越大，运动越快，默认100
            sp.damping = 10.f;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快，默认10
            sp.initialVelocity = 10.0f;//动画视图的初始速度大小，默认0
            sp.duration = sp.settlingDuration;//;//结算时间 返回弹簧动画到停止时的估算时间
            sp.fillMode = kCAFillModeForwards;//动画结束后复原
            sp.autoreverses = NO;//不做逆动画
            sp.removedOnCompletion = YES;//动画结束后移除
            if (idx > 3) {
                sp.fromValue = [NSValue valueWithCGPoint:CGPointMake(x + BHButtonWidth/2,BHButtonWidth/2+BHButtonWidth + BHButtonEdge)];
            }else{
                sp.fromValue = [NSValue valueWithCGPoint:CGPointMake(x + BHButtonWidth/2,BHButtonWidth/2)];
            }
            sp.toValue = [NSValue valueWithCGPoint:CGPointMake(x + BHButtonWidth/2 ,weakself.frame.size.height+BHButtonWidth/2)];
            btn.frame = CGRectMake(x ,0 , width, height);
            [btn.layer addAnimation:sp forKey:@"spring"];
        });
    }];
    
}

- (void)moveInAnimation{
    [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BHBCustomBtn * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        btn.frame = CGRectMake(x, self.frame.size.height, width, height);
        btn.alpha = 1;
        __weak typeof(self) weakself = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            btn.alpha = 0.5;
            [UIView animateWithDuration:0.5 animations:^{
                btn.alpha = 1;
            } completion:^(BOOL finished) {
                if ([btn isEqual:[weakself.visableBtnArray lastObject]]) {
                    weakself.superview.superview.userInteractionEnabled = YES;
                }
            }];
            
            CASpringAnimation *sp = [CASpringAnimation animationWithKeyPath:@"position"];
            sp.mass = 0.65;//质量，影响图层运动时的弹簧惯性,质量越大，弹簧拉伸和压缩的幅度越大,默认1
            sp.stiffness = 100.0f;//弹性系数，弹性系数越大，形变产生的力就越大，运动越快，默认100
            sp.damping = 10.f;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快，默认10
            sp.initialVelocity = 10.0f;//动画视图的初始速度大小，默认0
            sp.duration = sp.settlingDuration;//;//结算时间 返回弹簧动画到停止时的估算时间
            sp.fillMode = kCAFillModeForwards;//动画结束后复原
            sp.autoreverses = NO;//不做逆动画
            sp.removedOnCompletion = YES;//动画结束后移除
            sp.fromValue = [NSValue valueWithCGPoint:CGPointMake(x + BHButtonWidth/2,weakself.frame.size.height - BHButtonWidth)];
            if (idx > 3) {
                btn.frame = CGRectMake(x ,BHButtonWidth + BHButtonEdge, width, height);
                sp.toValue = [NSValue valueWithCGPoint:CGPointMake(x + BHButtonWidth/2,BHButtonWidth/2 + BHButtonWidth + BHButtonEdge)];
            }else{
                btn.frame = CGRectMake(x ,0 , width, height);
                sp.toValue = [NSValue valueWithCGPoint:CGPointMake(x + BHButtonWidth/2,BHButtonWidth/2)];
            }
            [btn.layer addAnimation:sp forKey:@"spring"];
        });
    }];
}

- (void)btnPositonAnimation:(BOOL)isDismis{
    if (self.visableBtnArray.count <= 0) {
        [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.visableBtnArray addObject:obj];
        }];
    }
    self.superview.superview.userInteractionEnabled = NO;
    if (isDismis) {
        [self removeAnimation:10000];
    }else{
        [self moveInAnimation];
    }
    
}

- (void)dealloc{
    NSLog(@"BHBCenterView");
}

@end
