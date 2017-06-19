//
//  FirstLineTableViewCell.h
//  TV_Program
//
//  Created by BigKing on 2017/6/19.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (void)moveStart;

@end
