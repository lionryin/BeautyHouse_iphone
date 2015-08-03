//
//  OrderVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderVC.h"
#import "OrderView.h"

#import "CommentAunt.h"
#import "OrderPayVC.h"


@interface OrderVC ()<OrderViewDelegate, CommentAuntDelegate, OrderPayVCDelegate>

@property (strong, nonatomic) OrderView *mOrderView;


@end

@implementation OrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单";
    
    self.edgesForExtendedLayout =UIRectEdgeNone ;
    
    if (_mOrderView == nil) {
        _mOrderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-49)];
        _mOrderView.delegate = self;
    }
    [self.view addSubview:_mOrderView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - orderView delegate
- (void)orderViewCommentOrder:(NSDictionary *)orderItem {
    CommentAunt *commentAunt = [[CommentAunt alloc] initWithNibName:@"CommentAunt" bundle:nil];
     commentAunt.orderItem= orderItem;
     commentAunt.delegate = self;
     [self.navigationController pushViewController:commentAunt animated:YES];
}

- (void)orderviewZhifuOrder:(NSDictionary *)orderItem {
    OrderPayVC *orderPayVC = [[OrderPayVC alloc] initWithNibName:@"OrderPayVC" bundle:nil];
     orderPayVC.orderItem = orderItem;
     orderPayVC.delegate = self;
     [self.navigationController pushViewController:orderPayVC animated:YES];
}

#pragma mark - orderPayVC delegate
- (void)orderPayVCPaySuccess{
    //[self setupRefresh:@"current"];
    _mOrderView.mScrollPageView.freshPage0 = YES;
    _mOrderView.mScrollPageView.freshPage2 = YES;
    _mOrderView.mScrollPageView.freshPage3 = YES;
    [_mOrderView.mScrollPageView freshContentTableAtIndex:_mOrderView.mScrollPageView.mCurrentPage];
}

#pragma mark - CommentAuntDelegate
- (void)commentAuntSuccess{
   // [self setupRefresh:@"history"];
    _mOrderView.mScrollPageView.freshPage0 = YES;
    _mOrderView.mScrollPageView.freshPage3 = YES;
    _mOrderView.mScrollPageView.freshPage4 = YES;
    [_mOrderView.mScrollPageView freshContentTableAtIndex:_mOrderView.mScrollPageView.mCurrentPage];
}


@end
