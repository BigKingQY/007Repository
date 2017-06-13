//
//  CustomTableViewCell.h
//  TV_Program
//
//  Created by BigKing on 2017/6/8.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end
