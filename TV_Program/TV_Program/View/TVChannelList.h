//
//  TVChannelList.h
//  TV_Program
//
//  Created by BigKing on 2017/6/6.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVChannelList : NSObject

@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *rel;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger tag;

+ (instancetype)sharedData;

- (NSArray *)channelListWithJson:(id)responseObj;

@end
