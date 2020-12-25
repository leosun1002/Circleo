//
//  MineMyAppointTableViewCell.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineMyAppointTableViewCell.h"

@implementation MineMyAppointTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cancelBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#999999"].CGColor;
    self.cancelBtn.layer.borderWidth = [UIScreen mainScreen].scale * 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(MyAppointModel *)model{
    _model = model;
    [self.smallHeadV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.goodsImg)]]];
    [self.headV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.goodsImg)]]];
    self.nameLabel.text = AssectString(model.businessName);
    self.titleLabel.text = AssectString(model.goodsName);
    self.timeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"预约时间：%@", nil),model.meetTime];
    switch ([model.status intValue]) {
        case 0:
        {
            self.stateLabel.text = NSLocalizedString(@"预约中", nil);
            [self.cancelBtn setTitle:NSLocalizedString(@"取消预约", nil) forState:(UIControlStateNormal)];
            break;
        }
        case 1:
        {
            self.stateLabel.text = NSLocalizedString(@"预约成功", nil);
            [self.cancelBtn setTitle:NSLocalizedString(@"取消预约", nil) forState:(UIControlStateNormal)];
            break;
        }
        case 2:
        {
            self.stateLabel.text = NSLocalizedString(@"预约失败", nil);
            [self.cancelBtn setTitle:NSLocalizedString(@"重新预约", nil) forState:(UIControlStateNormal)];
            break;
        }
        default:
            break;
    }
}

@end
