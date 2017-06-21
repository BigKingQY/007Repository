//
//  TVChannelList.m
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "TVChannelList.h"

@implementation TVChannelList

static TVChannelList *_channelList;
+ (instancetype)sharedData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_channelList) {
            _channelList = [[self alloc] init];
        }
    });
    return _channelList;
}

- (NSArray *)channelListWithJson:(id)responseObj{
    NSDictionary *json = responseObj;
    NSMutableArray *array = [NSMutableArray array];
    NSArray *result = json[@"result"];
    for (NSDictionary *dic in result) {
        TVChannelList *list = [TVChannelList new];
        list.pId = dic[@"pId"];
        list.rel = dic[@"rel"];
        list.url = dic[@"url"];
        list.channelName = dic[@"channelName"];
        list.isSelected = NO;
        [array addObject:list];
    }

    return [array copy];
}

@end
