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

/**
 单例对象

 @return 单例对象
 */
+ (instancetype)sharedDataManager;


/**
 按电视节目的分类请求数据

 @param suceess 成功的block
 @param failure 失败的block
 */
- (void)requestWithTVCategory:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure;


/**
 按具体节目分类的名字请求数据

 @param pId 分类id
 @param suceess 成功的block
 @param failure 失败的block
 */
- (void)requestWithTVChannelListWithpId:(NSString *)pId success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure;


/**
 按具体的节目请求节目单数据

 @param code 节目代码
 @param date 节目单日期
 @param suceess 成功的block
 @param failure 失败的block
 */
- (void)requestWithTVProgramWithCode:(NSString *)code date:(NSString *)date success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure;



@end
