//
//  OrderPaySuccessVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderPaySuccessDelegate <NSObject>

- (void)orderPaySuccessVCLeftButtonClicked;

@end

@interface OrderPaySuccessVC : UIViewController

@property (nonatomic, assign) id<OrderPaySuccessDelegate>delegate;

@end
