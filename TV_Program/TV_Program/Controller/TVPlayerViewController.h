//
//  TVPlayerViewController.h
//  TV_Program
//
//  Created by BigKing on 2017/6/20.
//  Copyright © 2017年 BigKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVPlayerViewController : UIViewController

@property (nonatomic, copy) NSString *url;

- (void)loadPlayerView;

@end
