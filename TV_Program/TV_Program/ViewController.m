//
//  ViewController.m
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "ViewController.h"
#import "TVDataManager.h"
#import "TVCategory.h"
#import "TVChannelList.h"
#import "TVProgramList.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *categorys;
@property (nonatomic, strong) NSArray *channelLists;
@property (nonatomic, strong) NSArray *programLists;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[TVDataManager sharedDataManager] requestWithTVCategory:^(id responseObj) {
        NSDictionary *dic = responseObj;
        TVCategory *category = [TVCategory new];
        self.categorys = [category categoryWithJson:dic];
        NSLog(@"%@", self.categorys);
    } failure:^(NSError *error) {
        
    }];
    
    [[TVDataManager sharedDataManager] requestWithTVChannelListWithpId:@"5" success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        TVChannelList *channelList = [TVChannelList new];
        self.channelLists = [channelList channelListWithJson:dic];
        NSLog(@"%@", self.channelLists);
    } failure:^(NSError *error) {
        
    }];
    
    [[TVDataManager sharedDataManager] requestWithTVProgramWithCode:@"cctv6" date:nil success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        TVProgramList *programList = [TVProgramList new];
        self.programLists = [programList programListWithJson:dic];
        NSLog(@"%@", self.programLists);
    } failure:^(NSError *error) {
        
    }];

}



@end
