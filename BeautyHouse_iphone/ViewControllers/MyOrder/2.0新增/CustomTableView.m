//
//  CustomTableView.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CustomTableView.h"
#import "MJRefresh.h"

@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (_homeTableView == nil) {
            _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
            _homeTableView.delegate = self;
            _homeTableView.dataSource = self;
            [_homeTableView setBackgroundColor:[UIColor clearColor]];
        }
        if (_tableInfoArray == Nil) {
            _tableInfoArray = [[NSMutableArray alloc] init];
        }
        [self addSubview:_homeTableView];
    }
    return self;
}

#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh:(NSString *)dateKey {
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [_homeTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [_homeTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_homeTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _homeTableView.headerPullToRefreshText = @"下拉可以刷新";
    _homeTableView.headerReleaseToRefreshText = @"松开马上刷新";
    _homeTableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
    
    _homeTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _homeTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    _homeTableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
}

- (void)headerRereshing {
    
    if ([_delegate respondsToSelector:@selector(refreshHeaderData:FromView:)]) {
        [_delegate refreshHeaderData:^{
            
            // 刷新表格
            [_homeTableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_homeTableView headerEndRefreshing];

        } FromView:self];
    }
    else {
        [_homeTableView headerEndRefreshing];
    }
    
}

- (void)footerRereshing {
    
    if ([_delegate respondsToSelector:@selector(reFreshFooterData:FromView:)]) {
        [_delegate reFreshFooterData:^{
            
            // 刷新表格
            [_homeTableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_homeTableView footerEndRefreshing];

            
        } FromView:self];
    }
    else {
         [_homeTableView footerEndRefreshing];
    }
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:FromView:)]) {
        NSInteger section = [_dataSource numberOfSectionsInTableView:tableView FromView:self];
        return section;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataSource respondsToSelector:@selector(numberOfRowsInTableView:InSection:FromView:)]) {
        NSInteger vRows = [_dataSource numberOfRowsInTableView:tableView InSection:section FromView:self];
        return vRows;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataSource respondsToSelector:@selector(cellForRowInTableView:IndexPath:FromView:)]) {
        UITableViewCell *vCell = [_dataSource cellForRowInTableView:tableView IndexPath:indexPath FromView:self];
        return vCell;
    }
    return Nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(heightForRowAthIndexPath:IndexPath:FromView:)]) {
        float vRowHeight = [_delegate heightForRowAthIndexPath:tableView IndexPath:indexPath FromView:self];
        return vRowHeight;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([_delegate respondsToSelector:@selector(didSelectedRowAthIndexPath:IndexPath: FromView:)]) {
        [_delegate didSelectedRowAthIndexPath:tableView IndexPath:indexPath FromView:self];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}





@end
