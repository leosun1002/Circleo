//
//  MineDraftsTableViewCell.h
//  ScmProject
//
//  Created by leosun on 2020/10/13.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineDraftsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailConst;

@end

NS_ASSUME_NONNULL_END
