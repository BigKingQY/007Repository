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
    //判断一个对象是否是<null>的方法
    if (json[@"result"] != [NSNull null]) {
        NSMutableArray *array = [NSMutableArray array];
        NSArray *result = json[@"result"];
        for (NSDictionary *dic in result) {
            TVProgramList *program = [TVProgramList new];
            program.cName = dic[@"cName"];
            program.pName = dic[@"pName"];
            program.pUrl = dic[@"pUrl"];
            program.time = dic[@"time"];
            [array addObject:program];
        }
        return [array copy];
    }
    
    
    return nil;
}

@end
