//
//  HomeGraphicFirstHeader.h
//  ScmProject
//
//  Created by leosun on 2020/9/30.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTagImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeGraphicFirstHeader : UIView<ZYTagImageViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *botView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) UIScrollView *scroll;

@end

NS_ASSUME_NONNULL_END
