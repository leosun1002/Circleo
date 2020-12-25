//
//  HomePageCollectionViewCell.h
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomePageCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)RACSubject *subject;
@property(nonatomic,strong)HomeNewModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

NS_ASSUME_NONNULL_END
