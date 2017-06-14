//
//  CustomTableHeaderView.m
//  TV_Program
//
//  Created by BigKing on 2017/6/14.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "CustomTableHeaderView.h"

@interface CustomTableHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *yestodayBtn;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *datePickBtn;


@end

@implementation CustomTableHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:242.f/255 green:242.f/255 blue:242.f/255 alpha:1];
    self.yestodayBtn.layer.cornerRadius = 15;
    self.tomorrowBtn.layer.cornerRadius = 15;
}


- (IBAction)clickYestodayBtn:(id)sender {
}

- (IBAction)clickTomorrowBtn:(id)sender {
}

- (IBAction)clickDatePickerBtn:(id)sender {
}



@end
