//
//  PublishHomeVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/19.
//  Copyright © 2020 session. All rights reserved.
//

#import "PublishHomeVC.h"
#import "PublishHomeCollectionViewCell.h"
#import "PublishAddTopicVC.h"
#import "PublishLocationVC.h"

@interface PublishHomeVC ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *locationView;

@end

@implementation PublishHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self addCollect];
    [self addBeizierPath];
}

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)prepareUi{
    self.closeBtn.transform = CGAffineTransformRotate(self.closeBtn.transform, M_PI_4);
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.titleText.placeholder attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:@"#9A9A9A"],
                 NSFontAttributeName:[UIFont systemFontOfSize:14]
         }];
    self.titleText.attributedPlaceholder = attrString;
    self.placeLabel.textColor = [UIColor colorWithRGBHex:@"#9A9A9A"];
    
    WeakSelf(self);
    UITapGestureRecognizer *locaTap = [[UITapGestureRecognizer alloc] init];
    [[locaTap rac_gestureSignal] subscribeNext:^(id x) {
        PublishLocationVC *location = [[PublishLocationVC alloc] init];
        [weakself.navigationController pushViewController:location animated:YES];
    }];
    [self.locationView addGestureRecognizer:locaTap];
}

-(void)addCollect{
    CGFloat width = (ksrcwidth - 40 - 30)/4;
    self.flowLayout.itemSize = CGSizeMake(width,width);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"PublishHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishHomeCollectionViewCell"];
    self.collectHeight.constant = width * 2 + 10;
}

-(void)addBeizierPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ksrcwidth, 70) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ksrcwidth, 70);
    maskLayer.path = path.CGPath;
    self.bottomView.layer.mask = maskLayer;
}

- (IBAction)addTopicClick:(id)sender {
    PublishAddTopicVC *addTopic = [[PublishAddTopicVC alloc] init];
    [self.navigationController pushViewController:addTopic animated:YES];
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.placeLabel.hidden = textView.text.length != 0;
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PublishHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PublishHomeCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
@end
