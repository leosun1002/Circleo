//
//  KLCodeResignView.h
//  ScmProject
//
//  Created by leosun on 2020/7/17.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CodeResignCompleted)(NSString *content);
typedef void (^CodeResignUnCompleted)(NSString *content);

@interface KLCodeResignView : UIView

@property (copy, nonatomic) CodeResignCompleted codeResignCompleted;
@property (copy, nonatomic) CodeResignUnCompleted codeResignUnCompleted;

- (instancetype) initWithCodeBits:(NSInteger)codeBits;

@end
