//
//  FirstLineTableViewCell.m
//  TV_Program
//
//  Created by BigKing on 2017/6/19.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "FirstLineTableViewCell.h"

@interface FirstLineTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation FirstLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.playImage.tintColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
//    self.playImage.image = [[UIImage imageNamed:@"ic_play_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    self.subLabel.textColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
    self.hotLabel.textColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
    self.dateLabel.textColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
    }
    return _detailLabel;
}

- (void)moveStart{
    self.detailLabel.numberOfLines = 1;
    
    self.detailLabel.textColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
    //自动适应文本宽度
    CGSize size = [self.detailLabel sizeThatFits:CGSizeMake(999, 30)];

    self.detailLabel.frame = CGRectMake(0, 0, size.width, size.height);
    CGPoint center = self.scrollView.center;
    center.x = self.scrollView.bounds.size.width;
    self.detailLabel.center = center;
    self.scrollView.contentSize = CGSizeMake(120, 43);
    [self.scrollView addSubview:self.detailLabel];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/30 target:self selector:@selector(moveLabel) userInfo:nil repeats:YES];
}

- (void)dealloc{
    [self.timer invalidate];
}

- (void)moveLabel{
    CGRect frame = self.detailLabel.frame;
    frame.origin.x -= 1;
    self.detailLabel.frame = frame;
    if (frame.origin.x <= -self.detailLabel.frame.size.width) {
        frame.origin.x = self.scrollView.bounds.size.width;
        self.detailLabel.frame = frame;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
