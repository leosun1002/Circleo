//
//  HomePageCollectionViewCell.m
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomePageCollectionViewCell.h"

@implementation HomePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addLongPresee];
}

-(void)addLongPresee{
    UILongPressGestureRecognizer *lop = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self addGestureRecognizer:lop];
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)lop
{
    if (lop.state == UIGestureRecognizerStateBegan) {
        [self.subject sendNext:@""];
    }
}

-(void)setModel:(HomeNewModel *)model{
    _model = model;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:AssectString(model.img)]];
    self.likeBtn.selected = [AssectString(model.isLike) isEqualToString:@"1"];
    self.likeCountLabel.text = AssectString(model.likeAmount);
    self.titleLabel.text = AssectString(model.title);
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:AssectString(model.photo)]];
    self.nameLabel.text = AssectString(model.name);
}
@end
