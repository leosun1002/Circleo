//
//  EmptyView.m
//  ScmProject
//
//  Created by leosun on 2019/7/31.
//  Copyright © 2019 session. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

+(instancetype)flagView{
    return [[[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil]lastObject];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
    }
    return self;
}

@end
