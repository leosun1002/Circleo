//
//  MineOrderTableViewCell.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineOrderTableViewCell.h"

@implementation MineOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cancleBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.cancleBtn.layer.borderWidth = [[UIScreen mainScreen] scale] * 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
