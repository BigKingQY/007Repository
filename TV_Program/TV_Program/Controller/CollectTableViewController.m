//
//  CollectTableViewController.m
//  TV_Program
//
//  Created by BigKing on 2017/6/7.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "CollectTableViewController.h"
#import "TVDataManager.h"
#import "TVChannelList.h"
#import "CustomTableViewCell.h"
#import "SubTableViewController.h"

@interface CollectTableViewController ()

@property (nonatomic, strong) NSMutableArray *collectData;
@property (nonatomic, strong) UIView *backView;


@end

@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)getCollectData:(NSNotification *)notification{
    TVChannelList *channel = notification.userInfo[@"channel"];
    channel.tag = [notification.userInfo[@"Tag"] integerValue];
    if ([self.collectData containsObject:channel]) {
        for (TVChannelList *cl in self.collectData) {
            if (channel == cl && channel.isSelected == NO) {
                [self.collectData removeObject:channel];
                break;
            }
        }
    }else{
        [self.collectData addObject:channel];
    }
    
    [self.tableView reloadData];
}


- (NSMutableArray *)collectData{
    if (!_collectData) {
        _collectData = [NSMutableArray array];
    }
    return _collectData;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.collectData.count == 0) {
        _backView = [[UIView alloc] initWithFrame:self.tableView.frame];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 300, 48)];
        label.text = @"暂无收藏频道，点击☆可收藏频道哦";
        label.textColor = [UIColor darkGrayColor];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:label];
        [self.view addSubview:_backView];
        [self.view layoutIfNeeded];
    }
    if (self.collectData.count > 0) {
        if ([self.view.subviews containsObject:_backView]) {
            [_backView removeFromSuperview];
            _backView = nil;
        }
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.collectData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    TVChannelList *channel = self.collectData[indexPath.row];
    cell.titleLabel.text = channel.channelName;
    cell.iconImageView.image = [UIImage imageNamed:channel.imageName];
    [cell.collectBtn addTarget:self action:@selector(removeCollect:) forControlEvents:UIControlEventTouchUpInside];
    cell.collectBtn.tag = indexPath.row;
    cell.collectBtn.selected = channel.isSelected;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)removeCollect:(UIButton *)sender{
    TVChannelList *channel = self.collectData[sender.tag];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeButtonStateNotification" object:self userInfo:@{@"channel" : channel}];
    [self.collectData removeObject:channel];
    [self.tableView reloadData];
    if (self.collectData.count == 0) {
        _backView = [[UIView alloc] initWithFrame:self.tableView.frame];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 300, 48)];
        label.text = @"暂无收藏频道，点击☆可收藏频道哦";
        label.textColor = [UIColor darkGrayColor];
        [_backView addSubview:label];
        [self.view addSubview:_backView];
        [self.view layoutIfNeeded];
    }
    if (self.collectData.count > 0) {
        if ([self.view.subviews containsObject:_backView]) {
            [_backView removeFromSuperview];
            _backView = nil;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TVChannelList *channel = self.collectData[indexPath.row];
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
