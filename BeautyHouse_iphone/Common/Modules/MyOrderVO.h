//
//  MyOrderVO.h
//  BeautyHouse
//
//  Created by Roy on 15/3/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kOrderTypeCurrent = 0,
    kOrderTypeHistory = 1
}EOrderType;


@interface MyOrderVO : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *orderID;

@property (nonatomic,assign)EOrderType orderType;

@end
