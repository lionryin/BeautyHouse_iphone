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

//#define imageURLPrefix @"http://218.244.143.58/beautiHouse/"
//#define MZBWebURL @"http://218.244.143.58/houseWs/ws/houseWs?wsdl"

#define imageURLPrefix @"http://www.mrchabo.com/beautiHouse/"
#define MZBWebURL @"http://www.mrchabo.com/houseWs/ws/houseWs?wsdl"


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
 获取订单
 @param param 接口入参
 */
+ (AFHTTPRequestOperation *)getCurrentOrderListWithParameter:(NSString *)jsonParam;






#pragma mark - Member Center







#pragma mark - My Account









@end
