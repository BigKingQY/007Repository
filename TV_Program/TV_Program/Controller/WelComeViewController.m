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

@property (weak, nonatomic) IBOutlet UIButton *backSkipBtn;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger timeInterval;

@end

static NSInteger kTimeInterval = 5;

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timeInterval = kTimeInterval;
    self.backSkipBtn.layer.cornerRadius = 10;
    //self.skipBtn.layer.cornerRadius = 15;
    [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(clickSkipBtn:) userInfo:nil repeats:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeLabel:) userInfo:nil repeats:YES];
}

- (void)changeLabel:(NSTimer *)timer{
    _timeInterval--;
    [self.backSkipBtn setTitle:[NSString stringWithFormat:@"跳过 %lds", _timeInterval] forState:UIControlStateNormal];
}

- (IBAction)clickSkipBtn:(NSTimer *)timer {
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
//    UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
//    // 在这里加一个这个样式的循环
//    while (topRootViewController.presentedViewController)
//    {
//        // 这里固定写法
//        topRootViewController = topRootViewController.presentedViewController;
//    }
//    // 然后再进行present操作
//    [topRootViewController presentViewController:tabbar animated:YES completion:^{
//        [self.timer invalidate];
//    }];

    
}



@end
