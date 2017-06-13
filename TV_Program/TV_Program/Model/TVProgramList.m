//
//  TVProgramList.m
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "TVProgramList.h"

@implementation TVProgramList


static TVProgramList *_programList;
+ (instancetype)sharedData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_programList) {
            _programList = [[self alloc] init];
        }
    });
    return _programList;
}


-(NSArray *)programListWithJson:(id)responseObj{
    NSDictionary *json = responseObj;
    NSMutableArray *array = [NSMutableArray array];
    NSArray *result = json[@"result"];
    for (NSDictionary *dic in result) {
        self.cName = dic[@"cName"];
        self.pName = dic[@"pName"];
        self.pUrl = dic[@"pUrl"];
        self.time = dic[@"time"];
        [array addObject:self];
    }
    return [array copy];
}

@end
