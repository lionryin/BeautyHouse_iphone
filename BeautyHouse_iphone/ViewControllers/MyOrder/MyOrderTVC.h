//
//  MyOrderTVC.h
//  BeautyHouse
//
//  Created by Roy on 15/3/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
#import "MyOrderVO.h"



@class MyOrderTVC;

@protocol MyOrderTVCDelegate <NSObject>

- (void)complaintBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell;
- (void)cancelBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell;


@end

@interface MyOrderTVC : BaseTVC

@property (nonatomic,weak)id<MyOrderTVCDelegate>delegate;

- (void)updateMyOrderTVC:(MyOrderVO *)orderVO;


@end
