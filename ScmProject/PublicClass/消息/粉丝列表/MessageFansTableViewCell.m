//
//  MessageFansTableViewCell.m
//  ScmProject
//
//  Created by leosun on 2020/10/9.
//  Copyright © 2020 session. All rights reserved.
//

#import "MessageFansTableViewCell.h"

@implementation MessageFansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.flowBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.flowBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FansModel *)model{
    _model = model;
    [self.headV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.photo)]]];
    self.nameLabel.text = AssectString(model.name);
    self.sexImgV.image = [AssectString(model.sex) isEqualToString:@"2"]?[UIImage imageNamed:@"gender_w"]:[UIImage imageNamed:@"gender_m"];
    self.areaLabel.text = [NSString stringWithFormat:@"%@  %@",AssectString(model.area),AssectString(model.createDate)];
    [self.flowBtn setTitle:model.isAttention == 1?NSLocalizedString(@"互相关注", nil):NSLocalizedString(@"关注", nil) forState:(UIControlStateNormal)];
    self.flowWidth.constant = model.isAttention == 1?77.5:53.5;
}
@end
