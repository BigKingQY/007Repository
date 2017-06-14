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

@interface SubTableViewController ()

@property (nonatomic, strong) NSArray *programDatas;
@property (nonatomic, strong) UILabel *label;

@end

@implementation SubTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomTableHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableHeaderView" owner:nil options:nil] firstObject];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"加载中...", nil);
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    [[TVDataManager sharedDataManager] requestWithTVProgramWithCode:self.channel.rel date:nil success:^(id responseObj) {
        self.programDatas = [[TVProgramList sharedData] programListWithJson:responseObj];
        if (self.programDatas.count != 0) {
            [hud hideAnimated:YES];
            [self.tableView reloadData];
        }else{
            [hud hideAnimated:YES];
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 275, 50)];
            self.label.textAlignment = NSTextAlignmentCenter;
            self.label.text = @"当前频道暂时没有节目单!";
            [self.view addSubview:self.label];
        }
        
    } failure:^(NSError *error) {
        [hud hideAnimated:YES];
        NSLog(@"失败");
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.programDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVProgramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TVProgramTableViewCell" owner:nil options:nil] firstObject];
    }
    
    TVProgramList *program = self.programDatas[indexPath.row];
    cell.dateLabel.text = [[program.time componentsSeparatedByString:@" "] lastObject];
    cell.detailLabel.text = program.pName;
    
    return cell;
}


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
