//
//  MerchantHomeTableViewCell.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "MerchantHomeTableViewCell.h"

@implementation MerchantHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tipLabel.layer.borderColor = [UIColor colorWithRGBHex:@"#CACACA"].CGColor;
    self.tipLabel.layer.borderWidth = [[UIScreen mainScreen] scale] * 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
