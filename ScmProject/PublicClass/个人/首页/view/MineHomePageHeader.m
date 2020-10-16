//
//  MineHomePageHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/11.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineHomePageHeader.h"
#import "MineHomeHeaderCollectionViewCell.h"

//订单
#import "MineOrderVC.h"
//预约
#import "MineMyAppointVC.h"
//收藏
#import "MineCollectionVC.h"
//钱包
#import "MineWalletVC.h"
//草稿箱
#import "MineDraftsVC.h"
//邀请好友
#import "MineInviteFriendVC.h"
//设置
#import "MineSettingVC.h"

@interface MineHomePageHeader ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConst;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (copy, nonatomic) NSArray *names;
@property (copy, nonatomic) NSArray *icons;

@end

@implementation MineHomePageHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"MineHomePageHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self prepareUi];
        [self addBeizierPath];
        [self addCollect];
    }
    return self;
}

-(void)prepareUi{
    if (IS_IPHONEX) {
        self.btnTopConst.constant += 20;
        self.topHeightConst.constant += 20;
    }
    self.editBtn.layer.borderColor = [UIColor colorWithRGBHex:@"#FFFFFF"].CGColor;
    self.editBtn.layer.borderWidth = [UIScreen mainScreen].scale * 1;
}

-(void)addBeizierPath{
    CGFloat heigth = IS_IPHONEX?300:280;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, heigth) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth, heigth);
    maskLayer.path = path.CGPath;
    self.topView.layer.mask = maskLayer;

}

-(void)addCollect{
    self.flowLayout.itemSize = CGSizeMake(ksrcwidth/4, 105);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    self.collectView.backgroundColor = [UIColor colorWithRGBHex:@"#F7F5FA"];
    [self.collectView registerNib:[UINib nibWithNibName:@"MineHomeHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MineHomeHeaderCollectionViewCell"];
}

- (IBAction)settingClick:(UIButton *)sender {
    MineSettingVC *setting = [[MineSettingVC alloc] init];
    [self.navigation pushViewController:setting animated:YES];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.names.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineHomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineHomeHeaderCollectionViewCell" forIndexPath:indexPath];
    cell.nameLabel.text = self.names[indexPath.item];
    cell.imgV.image = [UIImage imageNamed:self.icons[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        MineOrderVC *order = [[MineOrderVC alloc] init];
        [self.navigation pushViewController:order animated:YES];
    }else if (indexPath.item == 1){
        MineMyAppointVC *appoint = [[MineMyAppointVC alloc] init];
        [self.navigation pushViewController:appoint animated:YES];
    }else if (indexPath.item == 2){
        MineCollectionVC *collect = [[MineCollectionVC alloc] init];
        [self.navigation pushViewController:collect animated:YES];
    }else if (indexPath.item == 3){
        MineWalletVC *wallet = [[MineWalletVC alloc] init];
        [self.navigation pushViewController:wallet animated:YES];
    }else if (indexPath.item == 4){
        MineDraftsVC *draft = [[MineDraftsVC alloc] init];
        [self.navigation pushViewController:draft animated:YES];
    }else if (indexPath.item == 5){
        MineInviteFriendVC *friendVC = [[MineInviteFriendVC alloc] init];
        [self.navigation pushViewController:friendVC animated:YES];
    }
}

#pragma -getter
-(NSArray *)names{
    if (!_names) {
        _names = @[NSLocalizedString(@"我的订单", nil),NSLocalizedString(@"我的预约", nil),NSLocalizedString(@"我的收藏", nil),NSLocalizedString(@"我的钱包", nil),
                   NSLocalizedString(@"草稿箱", nil),NSLocalizedString(@"邀请好友", nil),NSLocalizedString(@"商家入驻", nil),NSLocalizedString(@"联系客服", nil)];
    };
    return _names;
}

-(NSArray *)icons{
    if (!_icons) {
        _icons = @[@"order_mine",@"appoint_mine",@"collection_mine",@"wallet_mine",
                   @"draft_mine",@"invite_mine",@"merchants_mine",@"service_mine"];
    };
    return _icons;
}
@end
