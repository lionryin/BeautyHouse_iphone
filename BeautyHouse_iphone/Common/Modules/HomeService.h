//
//  HomeService.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MzbService.h"
#import "MzbAd.h"
#import "MzbAddress.h"

@interface HomeService : NSObject

//@property (strong, nonatomic) NSString *result;
//@property (strong, nonatomic) NSArray *resultInfo;

//获取主页服务
- (void)getHomeServiceWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block;

//获取主页广告
- (void)getHomeAdWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block;

//获取全部服务
- (void)getAllServiceWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block;

//提交订单
- (void)saveOrdersWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result, NSString *orderID, NSError *error))block;
//取消订单
- (void)cancelOrdersWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result, NSError *error))block;

//添加服务地址
- (void)saveServiceAddressWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result, NSError *error))block;

//获取服务地址
- (void)getAllServiceAddressWihtParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result,NSArray *resultInfo, NSError *error))block;

//获取当前订单
- (void)getPageByOrderInfoWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result,NSDictionary *resultInfo, NSError *error))block;

//获取订单日志
- (void)getOrderLogListWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result,NSNumber *orderStatus,NSArray *resultInfo, NSError *error))block;

//登陆用户的余额查询
- (void)balanceOfUserQueriesWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result,NSNumber *resultInfo, NSError *error))block;

//登陆用户余额支付订单
- (void)balancesPayWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSNumber *result, NSError *error))block;

@end
