//
//  FillInformationVC.h
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    FillInformationLogin,
    FillInformationMine,
} FillInformationType;
NS_ASSUME_NONNULL_BEGIN

@interface FillInformationVC : BaseViewController

@property(nonatomic,assign)FillInformationType fillType;
@end

NS_ASSUME_NONNULL_END
