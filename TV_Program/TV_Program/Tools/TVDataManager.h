//
//  TVDataManager.h
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"



@interface TVDataManager : NSObject

+ (instancetype)sharedDataManager;

- (void)requestWithTVCategory:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure;

- (void)requestWithTVChannelListWithpId:(NSString *)pId success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure;

- (void)requestWithTVProgramWithCode:(NSString *)code date:(NSString *)date success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure;



@end
