//
//  TVCategory.m
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "TVCategory.h"

@implementation TVCategory

static TVCategory *_cateGory;
+ (instancetype)sharedData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_cateGory) {
            _cateGory = [[self alloc]init];
        }
    });
    return _cateGory;
}

- (NSArray *)categoryWithJson:(id)responseObj{
    NSDictionary *json = responseObj;
    NSMutableArray *array = [NSMutableArray array];
    NSArray *result = json[@"result"];
    for (NSDictionary *dic in result) {
        self.pId = dic[@"pId"];
        self.name = dic[@"name"];
        [array addObject:self];
    }
    return [array copy];
}

@end
