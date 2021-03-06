//
//  OtherTableViewController.m
//  TV_Program
//
//  Created by BigKing on 2017/6/7.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "OtherTableViewController.h"
#import "TVDataManager.h"
#import "TVChannelList.h"
#import "CustomTableViewCell.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "SubTableViewController.h"
#import "FailuerView.h"

@interface OtherTableViewController ()

@property (nonatomic, strong) NSMutableArray *tvData;
@property (nonatomic, weak) FailuerView *failuerView;

@end

@implementation OtherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadViewAndRequest];
}

- (void)loadViewAndRequest{
    //移除加载失败的页面
    if ([self.view.subviews containsObject:_failuerView]) {
        [_failuerView removeFromSuperview];
    }
    //去掉多余的空白cell
    self.tableView.tableFooterView = [UIView new];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"加载中...", nil);
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.tvData = [NSMutableArray array];
    [self.tableView setNeedsDisplay];
    for (int i = 4; i < 7; i++) {
        [[TVDataManager sharedDataManager] requestWithTVChannelListWithpId:[NSString stringWithFormat:@"%d", i] success:^(id responseObj) {
            NSArray *array = [[TVChannelList sharedData] channelListWithJson:responseObj];
            for (TVChannelList *channelList in array) {
                [self.tvData addObject:channelList];
            }
            [self.tableView reloadData];
            [hud hideAnimated:YES];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            if (![self.view.subviews containsObject:_failuerView]) {
                FailuerView *failuerView = [[[NSBundle mainBundle] loadNibNamed:@"FailuerView" owner:nil options:nil] lastObject];
                _failuerView = failuerView;
                [_failuerView.reloadButton addTarget:self action:@selector(reloadDatas:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_failuerView];
            }
        }];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonState:) name:@"ChangeButtonStateNotification" object:nil];
}

- (void)reloadDatas:(UIButton *)sender{
    [self loadViewAndRequest];
}

- (void)changeButtonState:(NSNotification *)noti{
    TVChannelList *channel = noti.userInfo[@"channel"];
    channel.isSelected = NO;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tvData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    TVChannelList *channel = self.tvData[indexPath.row];
    channel.imageName = @"CNTV";
    
    cell.titleLabel.text = channel.channelName;
    cell.iconImageView.image = [UIImage imageNamed:channel.imageName];
    cell.collectBtn.tag = indexPath.row;
    cell.collectBtn.selected = channel.isSelected;
    [cell.collectBtn addTarget:self action:@selector(addToCollect:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)addToCollect:(UIButton *)sender{
    TVChannelList *channel = self.tvData[sender.tag];
    sender.selected = !sender.selected;
    channel.isSelected = sender.selected;
    NSDictionary *dic = @{@"channel":channel, @"Tag":[NSNumber numberWithInteger:sender.tag]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TVChannelNotification" object:self userInfo:dic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TVChannelList *channel = self.tvData[indexPath.row];
    SubTableViewController *vc = [[SubTableViewController alloc] initWithNibName:@"SubTableViewController" bundle:nil];
    vc.title = [NSString stringWithFormat:@"%@节目单", channel.channelName];
    vc.channel = channel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
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
