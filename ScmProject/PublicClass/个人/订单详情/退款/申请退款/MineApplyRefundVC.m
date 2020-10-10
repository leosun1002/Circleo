//
//  MineApplyRefundVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/10.
//  Copyright © 2020 session. All rights reserved.
//

#import "MineApplyRefundVC.h"
#import "MineApplyRefundCollectionViewCell.h"

@interface MineApplyRefundVC ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextView *reasonText;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectHeight;

@end

@implementation MineApplyRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareUi{
    self.heightConst.constant = navBarHeight;
    
    CGFloat width = (ksrcwidth - 40)/3;
    self.flowLayout.itemSize = CGSizeMake(width,width);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"MineApplyRefundCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MineApplyRefundCollectionViewCell"];
    self.collectHeight.constant = width*2;
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.placeLabel.hidden = textView.text.length != 0;
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineApplyRefundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineApplyRefundCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
@end
