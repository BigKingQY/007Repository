//
//  TVPlayerViewController.m
//  TV_Program
//
//  Created by BigKing on 2017/6/20.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "TVPlayerViewController.h"
#import "CLPlayerView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TVPlayerViewController ()

@property (weak, nonatomic) CLPlayerView *playView;

@end

@implementation TVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPlayerView];
}

- (void)loadPlayerView{
    
    CLPlayerView *playView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth / 16.0f * 9.0f)];
    playView.center = self.view.center;
    playView.url = [NSURL URLWithString:self.url];
    playView.isLandscape = YES;
    _playView = playView;
    [self.view addSubview:_playView];
    [_playView playVideo];
    [_playView backButton:^(UIButton *button) {
        //当视频不是在竖屏界面时，切换到原始竖屏界面。已经是竖屏界面了就dismiss掉
        if (_playView.isFullScreen) {
            [_playView originalscreen];
        }else{
            [_playView originalscreen];
            [_playView destroyPlayer];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
