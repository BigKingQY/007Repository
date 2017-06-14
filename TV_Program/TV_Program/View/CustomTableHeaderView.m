//
//  CustomTableHeaderView.m
//  TV_Program
//
//  Created by BigKing on 2017/6/14.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "CustomTableHeaderView.h"
#import "TVDataManager.h"


@interface CustomTableHeaderView ()

@property (strong, nonatomic) NSArray *week;
@property (strong, nonatomic) NSDate *currentDate;


@end

@implementation CustomTableHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:242.f/255 green:242.f/255 blue:242.f/255 alpha:1];
    self.yestodayBtn.layer.cornerRadius = 15;
    self.tomorrowBtn.layer.cornerRadius = 15;
    self.currentDate = [NSDate date];
    NSString *btnTitle = [self setDate:self.currentDate];
    [self.datePickBtn setTitle:btnTitle forState:UIControlStateNormal];
    self.datePickBtn.tintColor = [UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1];
}
//
//- (NSArray *)week{
//    if (!_week) {
//        _week = @[@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
//    }
//    return _week;
//}

- (NSString *)setDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *day = [formatter stringFromDate:date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSArray *weeks = @[@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    NSString *week = weeks[[components weekday] - 1];
    return [NSString stringWithFormat:@"%@(%@)", day, week];
}


@end
