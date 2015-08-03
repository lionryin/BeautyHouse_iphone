//
//  OrderView.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuHrizontal.h"
#import "ScrollPageView.h"

@protocol OrderViewDelegate <NSObject>

- (void)orderViewCommentOrder:(NSDictionary *)orderItem;
- (void)orderviewZhifuOrder:(NSDictionary *)orderItem;

@end

@interface OrderView : UIView

@property (nonatomic, assign) id<OrderViewDelegate> delegate;

@property (strong, nonatomic) MenuHrizontal  *mMenuHriZontal;
@property (strong, nonatomic) ScrollPageView *mScrollPageView;

@end
