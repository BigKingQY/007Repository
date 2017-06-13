//
//  TVProgramList.h
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVProgramList : NSObject

@property (nonatomic, copy) NSString *cName;
@property (nonatomic, copy) NSString *pName;
@property (nonatomic, copy) NSString *pUrl;
@property (nonatomic, copy) NSString *time;

+ (instancetype)sharedData;

- (NSArray *)programListWithJson:(id)responseObj;

@end
