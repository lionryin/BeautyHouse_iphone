//
//  WebService.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MyPaser.h"
#import "Common.h"

#define imageURLPrefix @"http://218.244.143.58/mrchabo/"
#define MZBWebURL @"http://218.244.143.58/houseWs/ws/houseWs?wsdl"

//#define imageURLPrefix @"http://www.mrchabo.com/beautiHouse/"
//#define MZBWebURL @"http://www.mrchabo.com/houseWs/ws/houseWs?wsdl"

//#define imageURLPrefix @"http://27.16.132.50:1250/mrchabo/"
//#define MZBWebURL @"http://27.16.132.50:1250/houseWs/ws/houseWs?wsdl"

//#define imageURLPrefix @"http://59.174.6.165:1250/mrchabo/"
//#define MZBWebURL @"http://59.174.6.165:1250/houseWs/ws/houseWs?wsdl"

@interface MZBWebService : NSObject

/**
 WebService基类
 @param body 不同方法body不同
 */
+ (AFHTTPRequestOperation *)MZBWebService:(NSString *)body;

/**
 获取主页服务
 */
+ (AFHTTPRequestOperation *)getHomePageServiceCategroy;



/**
 获取主页广告
 */
+ (AFHTTPRequestOperation *)getHomeAppAdConfigure;

/**
 获取所有服务
 */
+ (AFHTTPRequestOperation *)getAllServiceCategroyParent;

#pragma mark - address

/**
 添加服务地址
 */
+ (AFHTTPRequestOperation *)saveServiceAddress:(NSString *)jsonParam;

/**
 获取服务地址
 */
+ (AFHTTPRequestOperation *)getAllServiceAddress:(NSString *)jsonParam;

#pragma mark - Login

/**
 *@function 获取验证码
 *@param 由手机号封装的json字符串
 */
+ (AFHTTPRequestOperation *)getPhoneVerifyCode:(NSString *)jsonParam;

/**
 *@function 登录
 *@param 由手机号和验证码封装的json字符串
 */
+ (AFHTTPRequestOperation *)login:(NSString *)jsonParam;



#pragma mark - Order
/**
 下单
 */
+ (AFHTTPRequestOperation *)saveOrderInfo:(NSString *)jsonParam;

/**
 退单
 */
+ (AFHTTPRequestOperation *)cancelOrderInfo:(NSString *)jsonParam;

/**
 *@function 获取当前订单列表
 *@param param 接口入参
 */
+ (AFHTTPRequestOperation *)getCurrentOrderListWithParameter:(NSString *)jsonParam;

/**
 *@function 获取历史订单列表
 *@param param 接口入参
 */
+ (AFHTTPRequestOperation *)getHistoryOrderListWithParameter:(NSString *)jsonParam;

/**
 获取订单日志
 */
+ (AFHTTPRequestOperation *)getOrderLogList:(NSString *)jsonParam;


#pragma mark - Member Center







#pragma mark - My Account

/**
 *@function 获取开通服务的城市
 *@param param 接口入参
 */
+ (AFHTTPRequestOperation *)getAvailableCitiesListWithParameter:(NSString *)jsonParam;


/**
 *@function 获取用户余额
 *@param param 接口入参
 */
+ (AFHTTPRequestOperation *)getUserBalanceWithParameter:(NSString *)jsonParam;


//用户的金币余额查询
+ (AFHTTPRequestOperation *)getBalanceOfUserGoldCoinsQueryWithParameter:(NSString *)jsonParam;

//用户金币交易记录查询
+ (AFHTTPRequestOperation *)getGoldCoinsTradeRecordWithParameter:(NSString *)jsonParam;

//金币兑换为现金
+ (AFHTTPRequestOperation *)goldCoinsExchangeWithParameter:(NSString *)jsonParam;


//登录用户的费用明细查询{} OR 登录用户的充值明细查询{}
+ (AFHTTPRequestOperation *)getListRechargeInfoWithParameter:(NSString *)jsonParam;


//问题反馈或建议
+ (AFHTTPRequestOperation *)saveMenberFeedBackWithParameter:(NSString *)jsonParam;


@end
