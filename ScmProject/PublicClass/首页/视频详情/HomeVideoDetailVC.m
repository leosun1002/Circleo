//
//  HomeVideoDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/1.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeVideoDetailVC.h"
#import "GKDYVideoPlayer.h"

@interface HomeVideoDetailVC ()<GKDYVideoPlayerDelegate>

@property (nonatomic, strong) GKDYVideoPlayer           *player; //播放器

@end

@implementation HomeVideoDetailVC
                                                                                                 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
}

-(void)prepareUi{
    [self.player playVideoWithView:self.view url:@"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/3516124_7c1eb724ef256b8d4e4eb30d34e16f4c_1.mp4"];
}

//播放器
- (GKDYVideoPlayer *)player {
    if (!_player) {
        _player = [GKDYVideoPlayer new];
        _player.delegate = self;
    }
    return _player;
}
- (void)player:(nonnull GKDYVideoPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress {
}

- (void)player:(nonnull GKDYVideoPlayer *)player statusChanged:(GKDYVideoPlayerStatus)status {
}




@end
