//
//  FansFollowTableViewCell.m
//  ScmProject
//
//  Created by leosun on 2020/10/2.
//  Copyright © 2020 session. All rights reserved.
//

#import "FansFollowTableViewCell.h"

@implementation FansFollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.flowBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#9A9A9A"].CGColor;
    self.flowBtn.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
