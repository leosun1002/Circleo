//
//  FEexChooseRecordView.h
//  Cloud Pro
//
//  Created by 董雷 on 2020/3/2.
//  Copyright © 2020 yunzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEexChooseRecordView : UIView

@property (nonatomic, copy) void (^clickBlock)(NSString *typeStr, NSString *typeName);

@end

NS_ASSUME_NONNULL_END
