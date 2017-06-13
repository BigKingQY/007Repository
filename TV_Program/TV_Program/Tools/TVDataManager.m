//
//  TVDataManager.m
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import "TVDataManager.h"
#import "AFNetWorking/AFNetWorking.h"
#import "TVChannelList.h"

#define APPKEY @"49184b6c35214e4b81173ba1710123eb"
#define TVURL @"http://api.avatardata.cn/"

@interface TVDataManager ()

@property (nonatomic, strong)void (^success)(id responseObj);
@property (nonatomic, strong)void (^failure)(NSError *error);

@end


@implementation TVDataManager

static TVDataManager *_dataManager;
+ (instancetype)sharedDataManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_dataManager) {
            _dataManager = [[self alloc] init];
        }
    });
    return _dataManager;
}


- (void)requestWithTVCategory:(void (^)(id))suceess failure:(void (^)(NSError *))failure{
    NSURL *baseURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@TVTime/Query", TVURL]];
    NSDictionary *param = @{@"key" : APPKEY};
    [self requestWithURL:baseURL param:param success:^(id responseObj) {
        suceess(responseObj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)requestWithTVChannelListWithpId:(NSString *)pId success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure{
    NSURL *baseURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@TVTime/LookUp", TVURL]];
    NSDictionary *param = @{@"key" : APPKEY, @"pId" : pId};
    [self requestWithURL:baseURL param:param success:^(id responseObj) {
        suceess(responseObj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestWithTVProgramWithCode:(NSString *)code date:(NSString *)date success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure{
    NSURL *baseURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@TVTime/TVlist", TVURL]];
    if (date == nil) {
        date = @"";
    }
    NSDictionary *param = @{@"key" : APPKEY, @"code" : code, @"date" : date};
    [self requestWithURL:baseURL param:param success:^(id responseObj) {
        suceess(responseObj);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)requestWithURL:(NSURL *)url param:(NSDictionary *)param success:(void (^)(id responseObj))suceess failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url.absoluteString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        suceess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
