//
//  HomeVideoDetailVC.m
//  ScmProject
//
//  Created by leosun on 2020/10/1.
//  Copyright © 2020 session. All rights reserved.
//

#import "HomeVideoDetailVC.h"
#import <AliyunPlayer/AliyunPlayer.h>
#import "HomeVideoDetailView.h"
#import "GKDYCommentView.h"
#import "GKSlidePopupView.h"

@interface HomeVideoDetailVC ()<AVPDelegate,HomeVideoDetailViewDelegate>

@property(nonatomic,strong)AliPlayer *player;
@property(nonatomic,strong)HomeVideoDetailView *homeView;
//是否暂停
@property(nonatomic,assign)BOOL isPausing;

@end

@implementation HomeVideoDetailVC

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.player destroy];
    self.player = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareData];
}
                                                                                                 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUi];
    [self prepareData];
    [self.view addSubview:self.homeView];
    [self addUnLike];
}

-(void)prepareUi{
    self.view.backgroundColor = [UIColor blackColor];
}

-(void)prepareData{
    //创建VidSts
    AVPUrlSource *source = [[AVPUrlSource alloc] init];
    source.playerUrl = [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/2148489_1c9d8082c70caa732fc0648a21be383c_1.mp4"];
     //设置播放源
    [self.player setUrlSource:source];
    [self.player prepare];
}

-(void)addUnLike{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer
    alloc] initWithTarget:self action:@selector(longPress:)];
    // 为该控件添加手势处理器
    [self.view addGestureRecognizer:gesture];
}

- (void) longPress:(UILongPressGestureRecognizer*)gesture{
    UIAlertController*   sheetVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction*  sheetBtn1=[UIAlertAction actionWithTitle:NSLocalizedString(@"保存至相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn1];
    [sheetBtn1 setValue:[UIColor colorWithRGBHex:@"#333333"] forKey:@"titleTextColor"];
    
    UIAlertAction*  sheetBtn2=[UIAlertAction actionWithTitle:NSLocalizedString(@"不感兴趣", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn2];
    [sheetBtn2 setValue:[UIColor colorWithRGBHex:@"#333333"] forKey:@"titleTextColor"];
    
    UIAlertAction*  sheetBtn3=[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn3];
    [sheetBtn3 setValue:[UIColor colorWithRGBHex:@"#999999"] forKey:@"titleTextColor"];
    
    [self presentViewController:sheetVC animated:YES completion:nil];
}

/**
 @brief 错误代理回调
 @param player 播放器player指针
 @param errorModel 播放器错误描述，参考AliVcPlayerErrorModel
 */
- (void)onError:(AliPlayer*)player errorModel:(AVPErrorModel *)errorModel {
    //提示错误，及stop播放
}

/**
 @brief 播放器事件回调
 @param player 播放器player指针
 @param eventType 播放器事件类型，@see AVPEventType
 */
-(void)onPlayerEvent:(AliPlayer*)player eventType:(AVPEventType)eventType {
    switch (eventType) {
        case AVPEventPrepareDone: {
            // 准备完成
        }
            break;
        case AVPEventAutoPlayStart:
            // 自动播放开始事件
            break;
        case AVPEventFirstRenderedStart:
            // 首帧显示
            break;
        case AVPEventCompletion:
            // 播放完成
            break;
        case AVPEventLoadingStart:
            // 缓冲开始
            break;
        case AVPEventLoadingEnd:
            // 缓冲完成
            break;
        case AVPEventSeekEnd:
            // 跳转完成
            break;
        case AVPEventLoopingStart:
            // 循环播放开始
            break;
        default:
            break;
    }
}

/**
 @brief 视频当前播放位置回调
 @param player 播放器player指针
 @param position 视频当前播放位置
 */
- (void)onCurrentPositionUpdate:(AliPlayer*)player position:(int64_t)position {
    // 更新进度条
}

/**
 @brief 视频缓存位置回调
 @param player 播放器player指针
 @param position 视频当前缓存位置
 */
- (void)onBufferedPositionUpdate:(AliPlayer*)player position:(int64_t)position {
    // 更新缓冲进度
}

/**
 @brief 获取track信息回调
 @param player 播放器player指针
 @param info track流信息数组 参考AVPTrackInfo
 */
- (void)onTrackReady:(AliPlayer*)player info:(NSArray<AVPTrackInfo*>*)info {
    // 获取多码率信息
}

/**
 @brief 获取截图回调
 @param player 播放器player指针
 @param image 图像
 */
- (void)onCaptureScreen:(AliPlayer *)player image:(UIImage *)image {
    // 预览，保存截图
}

#pragma -mark HomeVideoDetailViewDelegate
-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)playOrPauseClick{
    if (self.isPausing) {
        [self.player start];
        self.isPausing = NO;
        self.homeView.pauseImgV.hidden = YES;
    }else{
        [self.player pause];
        self.isPausing = YES;
        self.homeView.pauseImgV.hidden = NO;
    }
}

-(void)commentsClick{
    GKDYCommentView *commentView = [[GKDYCommentView alloc] initWithFrame:CGRectMake(0, ksrcheight - 470, ksrcwidth, 470)];
//    [self.view addSubview:commentView]
    GKSlidePopupView *popupView = [GKSlidePopupView popupViewWithFrame:[UIScreen mainScreen].bounds contentView:commentView];
    [popupView showFrom:[UIApplication sharedApplication].keyWindow completion:^{
        [commentView requestData];
    }];
}

#pragma -mark getter
-(HomeVideoDetailView *)homeView{
    if (!_homeView) {
        _homeView = [[HomeVideoDetailView alloc] init];
        _homeView.delegate = self;
    }
    return _homeView;
}

-(AliPlayer *)player{
    if (!_player) {
        _player = [[AliPlayer alloc] init];
        _player.delegate = self;
        _player.autoPlay = YES;
        _player.loop = YES;
        _player.playerView = self.view;
        //设置画面的镜像模式：水平镜像，垂直镜像，无镜像。
        _player.mirrorMode = AVP_MIRRORMODE_NONE;
        //设置画面旋转模式：旋转0度，90度，180度，270度
        _player.rotateMode = AVP_ROTATE_0;
        //设置画面缩放模式：宽高比填充，宽高比适应，拉伸填充
        _player.scalingMode = AVP_SCALINGMODE_SCALETOFILL;
    }
    return _player;
}
@end
