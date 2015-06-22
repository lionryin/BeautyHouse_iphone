//
//  SearchListTableVC.h
//  TestBaiduMap
//
//  Created by MacAir2 on 15/6/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchListTableVCDelegate <NSObject>

- (void)passValue:(NSString *)value;

@end

@interface SearchListTableVC : UITableViewController

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSString *selectedText;
@property (strong, nonatomic) NSMutableArray *resultList;
@property (assign, nonatomic) id<SearchListTableVCDelegate>delegate;

- (void)updateData;

@end
