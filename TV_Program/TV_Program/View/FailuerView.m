//
//  FailuerView.m
//  TV_Program
//
//  Created by BigKing on 2017/6/21.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "FailuerView.h"

@interface FailuerView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
    
@end

@implementation FailuerView

- (void)awakeFromNib{
    [super awakeFromNib];
    //此处可修改要提示的内容或者背景图片

    self.reloadButton.backgroundColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
    self.reloadButton.layer.cornerRadius = 10;
    
}

@end
