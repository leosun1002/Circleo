//
//  HomeGraphicFirstFooter.m
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeGraphicFirstFooter.h"

@implementation HomeGraphicFirstFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HomeGraphicFirstFooter" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
    }
    return self;
}

@end
