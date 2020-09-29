//
//  NSTimer+Block.m
//  ScmProject
//
//  Created by leosun on 2019/9/6.
//  Copyright © 2019 session. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

+ (instancetype)repeatWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *timer))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(trigger:) userInfo:[block copy] repeats:YES];
    return timer;
}

+ (void)trigger:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = [timer userInfo];
    if (block) {
        block(timer);
    }
}
@end
