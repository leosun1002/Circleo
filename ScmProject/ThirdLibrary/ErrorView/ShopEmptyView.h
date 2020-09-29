//
//  ShopEmptyView.h
//  ScmProject
//
//  Created by leosun on 2020/7/21.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopEmptyView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;

+(instancetype)flagView;

@end

NS_ASSUME_NONNULL_END
