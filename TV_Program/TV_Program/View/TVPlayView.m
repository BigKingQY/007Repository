//
//  TVPlayView.m
//  TV_Program
//
//  Created by BigKing on 2017/6/19.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "TVPlayView.h"
#import "CLPlayerView.h"

@interface TVPlayView ()

@property (weak, nonatomic) CLPlayerView *playerView;

@end


@implementation TVPlayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initPlayView];
    }
    return self;
}

- (void)initPlayView{
    
    [_playerView destroyPlayer];
    _playerView = nil;
    
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    playerView.isLandscape = YES;
    playerView.url = self.url;
    _playerView = playerView;
    [self addSubview:_playerView];
    [_playerView playVideo];
}

- (NSURL *)url{
    if (!_url) {
        _url = [[NSURL alloc] init];
    }
    return _url;
}



@end
