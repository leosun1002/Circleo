//
//  HomeLocationHeader.m
//  ScmProject
//
//  Created by leosun on 2020/10/3.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeLocationHeader.h"
#import "HomeSearchHistoryCollectionViewCell.h"

@interface HomeLocationHeader ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation HomeLocationHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HomeLocationHeader" owner:self options:nil] lastObject];
    if ([super initWithFrame:frame]) {
        self.frame=frame;
        [self addCollect];
    }
    return self;
}

-(void)addCollect{
    self.flowLayout.itemSize = CGSizeMake((ksrcwidth - 50)/3, 30);
    self.flowLayout.minimumLineSpacing = 15;
    self.flowLayout.minimumInteritemSpacing = 15;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"HomeSearchHistoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSearchHistoryCollectionViewCell"];
}

#pragma -mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSearchHistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSearchHistoryCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
@end
