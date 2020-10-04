//
//  HomeUserInfoHeader.h
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeUserInfoHeader : UIView

@property (weak, nonatomic) IBOutlet UIView *bgview;

@property(nonatomic,strong) RACSubject *subject;
@end

NS_ASSUME_NONNULL_END
