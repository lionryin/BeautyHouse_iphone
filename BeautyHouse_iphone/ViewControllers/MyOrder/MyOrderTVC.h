//
//  MyOrderTVC.h
//  BeautyHouse
//
//  Created by Roy on 15/3/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
#import "MyOrderVO.h"
#import "MBProgressHUD.h"


@class MyOrderTVC;

@protocol MyOrderTVCDelegate <NSObject>

- (void)complaintBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell;
- (void)cancelBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell;
- (void)zhifuBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell;


@end

@interface MyOrderTVC : BaseTVC

@property (nonatomic,weak)id<MyOrderTVCDelegate>delegate;
@property (strong, nonatomic) MyOrderVO *myOrderVO;

@property (strong, nonatomic) NSDictionary *orderItem;

- (CGFloat )updateMyOrderTVC;


@end
