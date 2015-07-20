//
//  ScrollPageView.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableView.h"
#import "MBProgressHUD.h"

#import "MyOrderTVC.h"

#define StatusKey   @"StatusKey"
#define NextPageKey @"NextPageKey"

@protocol ScrollPageViewDelegate <NSObject>
-(void)didScrollPageViewChangedPage:(NSInteger)aPage;
- (void)commentOrder:(NSDictionary *)orderItem;
- (void)zhifuOrder:(NSDictionary *)orderItem;
@end

@interface ScrollPageView : UIView<CustomTableViewDataSource, CustomTableViewDelegate, UIScrollViewDelegate, MyOrderTVCDelegate>

@property (nonatomic        ) NSInteger              mCurrentPage;
@property (nonatomic, strong) NSMutableArray         *statusOfPage;
@property (nonatomic, strong) MBProgressHUD          *hud;

@property (strong, nonatomic) UIScrollView           *scrollView;
@property (strong, nonatomic) NSMutableArray         *contentItems;
@property (nonatomic,assign ) id<ScrollPageViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame statusOfPage:(NSArray *)status;

#pragma mark 添加ScrollowViewd的ContentView
-(void)setContentOfTables:(NSInteger)aNumerOfTables;
#pragma mark 滑动到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex;
#pragma mark 刷新某个页面
-(void)freshContentTableAtIndex:(NSInteger)aIndex;


@end
