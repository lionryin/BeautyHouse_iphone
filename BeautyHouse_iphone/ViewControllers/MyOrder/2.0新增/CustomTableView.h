//
//  CustomTableView.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableView;

//delegate
@protocol CustomTableViewDelegate <NSObject>
@required;
-(float)heightForRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView;
-(void)didSelectedRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView;
-(void)refreshHeaderData:(void(^)())complete FromView:(CustomTableView *)aView;
-(void)reFreshFooterData:(void(^)())complete FromView:(CustomTableView *)aView;
@end

//dataSouce
@protocol CustomTableViewDataSource <NSObject>
@required;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView FromView:(CustomTableView *)aView;
-(NSInteger)numberOfRowsInTableView:(UITableView *)aTableView InSection:(NSInteger)section FromView:(CustomTableView *)aView;
-(UITableViewCell *)cellForRowInTableView:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView;

@end


@interface CustomTableView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView               *homeTableView;
@property (strong, nonatomic) NSMutableArray            *tableInfoArray;

@property (nonatomic,assign ) id<CustomTableViewDataSource> dataSource;
@property (nonatomic,assign ) id<CustomTableViewDelegate  > delegate;


#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh:(NSString *)dateKey;

@end
