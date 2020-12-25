//
//  MineApppointDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineApppointDetailVC.h"
#import "MyAppointModel.h"

@interface MineApppointDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *smallHeadV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UILabel *refuseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *refuseLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@end

@implementation MineApppointDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData{
    NSDictionary *dict = @{@"id": AssectString(self.appointId)};
    WeakSelf(self);
    [WebServices postWithUrl:@"my/mymeetdetails/" body:dict loadingTime:15. showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            MyAppointModel *modules = [MyAppointModel mj_objectWithKeyValues:result[resultData]];
            [weakself setData:modules];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(void)setData:(MyAppointModel *)model{
    [self.smallHeadV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.goodsImg)]]];
    [self.headV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",photoIp,AssectString(model.goodsImg)]]];
    self.nameLabel.text = AssectString(model.businessName);
    self.titleLabel.text = AssectString(model.goodsName);
    self.timeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"预约时间：%@", nil),model.meetTime];
    switch ([model.status intValue]) {
        case 0:
        {
            self.stateLabel.text = NSLocalizedString(@"预约中", nil);
            [self.checkBtn setTitle:NSLocalizedString(@"取消预约", nil) forState:(UIControlStateNormal)];
            self.refuseTimeLabel.hidden = YES;
            self.refuseLabel.hidden = YES;
            self.bottomHeight.constant = 90;
            break;
        }
        case 1:
        {
            self.stateLabel.text = NSLocalizedString(@"预约成功", nil);
            [self.checkBtn setTitle:NSLocalizedString(@"取消预约", nil) forState:(UIControlStateNormal)];
            self.refuseTimeLabel.hidden = NO;
            self.refuseLabel.hidden = YES;
            self.refuseTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"通过时间：%@", nil),model.passTime];
            self.bottomHeight.constant = 120;
            break;
        }
        case 2:
        {
            self.stateLabel.text = NSLocalizedString(@"预约失败", nil);
            [self.checkBtn setTitle:NSLocalizedString(@"重新预约", nil) forState:(UIControlStateNormal)];
            self.refuseTimeLabel.hidden = NO;
            self.refuseLabel.hidden = NO;
            self.refuseTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"拒绝时间：%@", nil),model.refuseTime];
            self.refuseLabel.hidden = [NSString stringWithFormat:NSLocalizedString(@"原因：%@", nil),@"..."];
            self.bottomHeight.constant = 150;
            break;
        }
        default:
            break;
    }
    self.appointNameLabel.text = AssectString(model.name);
    self.phoneLabel.text = AssectString(model.phone);
    self.orderLabel.text = [NSString stringWithFormat:NSLocalizedString(@"订单号：%@", nil),model.code];
    self.createLabel.text = [NSString stringWithFormat:NSLocalizedString(@"下单时间：%@", nil),model.meetTime];
}

@end
