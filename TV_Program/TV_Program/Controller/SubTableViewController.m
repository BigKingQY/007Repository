//
//  SubTableViewController.m
//  TV_Program
//
//  Created by BigKing on 2017/6/14.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "SubTableViewController.h"
#import "CustomTableHeaderView.h"
#import "TVDataManager.h"
#import "TVProgramList.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "TVProgramTableViewCell.h"
#import "FirstLineTableViewCell.h"
#import "TVPlayerViewController.h"
#import "CLPlayerView.h"
#import "TVPlayView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SubTableViewController ()

@property (nonatomic, strong) NSMutableArray *programDatas;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) CustomTableHeaderView *headerView;
@property (nonatomic, strong) NSDate *currentDate;




@end

@implementation SubTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadHeaderView];
    [self startRequestTVDataWithDate:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"play_button"] style:UIBarButtonItemStylePlain target:self action:@selector(clickPlay:)];
    self.navigationItem.rightBarButtonItem.accessibilityFrame = CGRectMake(0, 0, 44, 44);
    
}



- (NSMutableArray *)programDatas{
    if (!_programDatas) {
        _programDatas = [NSMutableArray array];
    }
    return _programDatas;
}

- (void)loadHeaderView{
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableHeaderView" owner:nil options:nil] firstObject];
    [self.headerView.yestodayBtn addTarget:self action:@selector(clickYestodayBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.tomorrowBtn addTarget:self action:@selector(clickTomorrowBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.datePickBtn addTarget:self action:@selector(clickDatePickerBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [UIView new];

}

- (void)startRequestTVDataWithDate:(NSString *)date{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"加载中...", nil);
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;

    [[TVDataManager sharedDataManager] requestWithTVProgramWithCode:self.channel.rel date:date success:^(id responseObj) {
        self.programDatas = [NSMutableArray arrayWithArray:[[TVProgramList sharedData] programListWithJson:responseObj]];
        [hud hideAnimated:YES];
        
        [self reloadView];
        
    } failure:^(NSError *error) {
        [hud hideAnimated:YES];
        NSLog(@"失败");
    }];
}

- (void)moveCurrentProgramToFirst{
    
    if ([self isToday:self.currentDate]) {
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *currentTime = [formatter stringFromDate:currentDate];
        //NSLog(@"%@", currentTime);
        NSArray *ctime = [[[currentTime componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"];
        NSInteger cSeconds = [ctime[0] integerValue] * 60 + [ctime[1] integerValue];
            
        int k = 0;
        for (int i = 0; i < self.programDatas.count; i++) {
            TVProgramList *program = self.programDatas[i];
            NSString *time = [[program.time componentsSeparatedByString:@" "] lastObject];
            NSArray *ptime = [time componentsSeparatedByString:@":"];
            NSInteger pSeconds = [ptime[0] integerValue] * 60 + [ptime[1] integerValue];
            if (cSeconds < pSeconds) {
                k = i;
                break;
            }
            
        }
        [self.programDatas exchangeObjectAtIndex:0 withObjectAtIndex:k-1];
    }
}

- (void)reloadView{
    if (self.programDatas.count != 0) {
        if ([self.view.subviews containsObject:self.label]) {
            [self.label removeFromSuperview];
        }
        [self moveCurrentProgramToFirst];
    }else{
        if (![self.view.subviews containsObject:self.label]) {
            [self.view addSubview:self.label];
        }
    }
    [self.tableView reloadData];
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 275, 50)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = @"当前日期暂时没有节目单哦~";
    }
    return _label;
}

#pragma mark --表头视图的三个按钮
- (void)clickYestodayBtn{
    self.currentDate = [NSDate dateWithTimeInterval:-24 * 3600 sinceDate:self.currentDate];
    NSString *btnTitle = [self.headerView setDate:self.currentDate];
    [self.headerView.datePickBtn setTitle:btnTitle forState:UIControlStateNormal];
    [self startRequestTVDataWithDate:[[btnTitle componentsSeparatedByString:@"("] firstObject]];
}

- (void)clickTomorrowBtn{
    self.currentDate = [NSDate dateWithTimeInterval:24 * 3600 sinceDate:self.currentDate];
    NSString *btnTitle = [self.headerView setDate:self.currentDate];
    [self.headerView.datePickBtn setTitle:btnTitle forState:UIControlStateNormal];
    [self startRequestTVDataWithDate:[[btnTitle componentsSeparatedByString:@"("] firstObject]];
}

//添加日期选择器
- (void)clickDatePickerBtn{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    datePicker.date = self.currentDate;
    [alterController.view addSubview:datePicker];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSTimeInterval interval = [datePicker.date timeIntervalSinceDate:self.currentDate];
            self.currentDate = [NSDate dateWithTimeInterval:interval sinceDate:self.currentDate];
            NSString *btnTitle = [self.headerView setDate:datePicker.date];
            [self.headerView.datePickBtn setTitle:btnTitle forState:UIControlStateNormal];
            [self startRequestTVDataWithDate:[[btnTitle componentsSeparatedByString:@"("] firstObject]];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alterController addAction:ok];
    [alterController addAction:cancel];
    [self presentViewController:alterController animated:YES completion:nil];
}

- (void)comparTwoDate:(NSDate *)dateA date:(NSDate *)dateB{
    NSTimeInterval interval = [dateA timeIntervalSinceDate:dateB];
    NSLog(@"%lf", interval);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.programDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVProgramList *program = self.programDatas[indexPath.row];
    //判断是否是第一行和是否是今天
    if (indexPath.row == 0 && [self isToday:self.currentDate]) {
        FirstLineTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstLineTableViewCell" owner:nil options:nil] firstObject];
        
        cell.dateLabel.text = [[program.time componentsSeparatedByString:@" "] lastObject];
        cell.detailLabel.text = program.pName;
        [cell moveStart];
        return cell;
    }else{
        TVProgramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TVProgramTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.dateLabel.text = [[program.time componentsSeparatedByString:@" "] lastObject];
        cell.detailLabel.text = program.pName;
        
        return cell;
    }
}

- (void)clickPlay:(UIButton *)sender{
    TVPlayerViewController *playerVC = [[TVPlayerViewController alloc] init];
    playerVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TVURL.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    playerVC.url = dic[self.channel.rel];
    [self.tabBarController presentViewController:playerVC animated:YES completion:nil];
    
}


- (BOOL)isToday:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *todayDate = [NSDate new];
    NSString *today = [formatter stringFromDate:todayDate];
    NSString *currentDay = [formatter stringFromDate:date];
    
    return [today isEqualToString:currentDay];
}

//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleNone;
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    
//}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
