//
//  CustomTableViewCell.m
//  TV_Program
//
//  Created by BigKing on 2017/6/8.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()




@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickBtn:(UIButton *)sender {
     
}

@end
