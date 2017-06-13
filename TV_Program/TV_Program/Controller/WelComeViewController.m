//
//  WelComeViewController.m
//  TV_Program
//
//  Created by BigKing on 2017/6/9.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "WelComeViewController.h"
#import "YSTableViewController.h"
#import "WSTableViewController.h"
#import "SZTableViewController.h"
#import "OtherTableViewController.h"
#import "CollectTableViewController.h"

@interface WelComeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skipBtn.layer.cornerRadius = 10;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(clickSkipBtn:) userInfo:nil repeats:NO];
 
}


- (IBAction)clickSkipBtn:(id)sender {
    [self jumpToNextSenece];
}

-(void)jumpToNextSenece{
    YSTableViewController *ysvc = [[YSTableViewController alloc] initWithNibName:@"YSTableViewController" bundle:[NSBundle mainBundle]];
    ysvc.title = @"央视";
    WSTableViewController *wsvc = [[WSTableViewController alloc] initWithNibName:@"WSTableViewController" bundle:[NSBundle mainBundle]];
    wsvc.title = @"卫视";
    SZTableViewController *szvc = [[SZTableViewController alloc] initWithNibName:@"SZTableViewController" bundle:[NSBundle mainBundle]];
    szvc.title = @"数字";
    OtherTableViewController *othervc = [[OtherTableViewController alloc] initWithNibName:@"OtherTableViewController" bundle:[NSBundle mainBundle]];
    othervc.title = @"更多";
    CollectTableViewController *collectvc = [[CollectTableViewController alloc] initWithNibName:@"CollectTableViewController" bundle:[NSBundle mainBundle]];
    collectvc.title = @"收藏";
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    UINavigationController *ysnavi = [[UINavigationController alloc] initWithRootViewController:ysvc];
    UINavigationController *wsnavi = [[UINavigationController alloc] initWithRootViewController:wsvc];
    UINavigationController *sznavi = [[UINavigationController alloc] initWithRootViewController:szvc];
    UINavigationController *othernavi = [[UINavigationController alloc] initWithRootViewController:othervc];
    UINavigationController *collectnavi = [[UINavigationController alloc] initWithRootViewController:collectvc];
    
    tabbar.viewControllers = @[ysnavi, wsnavi, sznavi, othernavi, collectnavi];
    //美化导航栏和工具栏
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1]];
    //[[UITabBar appearance] setTintColor:[UIColor orangeColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:246.f/255 green:246.f/255 blue:246.f/255 alpha:1]];
    
    [[UITabBarItem appearance]setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    //设置项的字体，大小，颜色（自然状态和选中状态需要分别设置）
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:160.f/255 blue:233.f/255 alpha:1]} forState:UIControlStateSelected];
    //[[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"background"]];
    tabbar.tabBar.items[0].image = [UIImage imageNamed:@"ic_live_tv"] ;
    tabbar.tabBar.items[1].image = [UIImage imageNamed:@"ic_ws"] ;
    tabbar.tabBar.items[2].image = [UIImage imageNamed:@"ic_toys"] ;
    tabbar.tabBar.items[3].image = [UIImage imageNamed:@"ic_more"] ;
    tabbar.tabBar.items[4].image = [UIImage imageNamed:@"ic_star"] ;
    [[NSNotificationCenter defaultCenter] addObserver:collectvc selector:@selector(getCollectData:) name:@"TVChannelNotification" object:nil];
    
    [self presentViewController:tabbar animated:YES completion:^{
        
        [self.timer invalidate];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
