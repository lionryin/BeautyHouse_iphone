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

/**
 下单
 */
+ (AFHTTPRequestOperation *)saveOrderInfo:(NSString *)jsonParam;




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
 *@function 获取当前订单列表
 *@param param 接口入参
 */
+ (AFHTTPRequestOperation *)getCurrentOrderListWithParameter:(NSString *)jsonParam;

/**
 *@function 获取历史订单列表
 *@param param 接口入参
 */
+ (AFHTTPRequestOperation *)getHistoryOrderListWithParameter:(NSString *)jsonParam;




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





@end
