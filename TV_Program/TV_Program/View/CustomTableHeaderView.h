//
//  CustomTableHeaderView.h
//  TV_Program
//
//  Created by BigKing on 2017/6/14.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *yestodayBtn;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *datePickBtn;

- (NSString *)setDate:(NSDate *)date;

@end
