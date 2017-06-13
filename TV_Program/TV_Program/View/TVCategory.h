//
//  TVCategory.h
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TVCategory : NSObject

@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *name;


+ (instancetype)sharedData;
- (NSArray *)categoryWithJson:(id)responseObj;

@end
