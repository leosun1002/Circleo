//
//  HomeVideoDetailView.h
//  ScmProject
//
//  Created by leosun on 2020/10/27.
//  Copyright © 2020 session. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeVideoDetailViewDelegate <NSObject>

-(void)popBack;
-(void)playOrPauseClick;
-(void)commentsClick;

@end

@interface HomeVideoDetailView : UIView

@property(nonatomic,weak) id<HomeVideoDetailViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *pauseImgV;

@end

NS_ASSUME_NONNULL_END
