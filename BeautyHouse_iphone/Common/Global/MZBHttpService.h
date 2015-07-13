//
//  MZBHttpService.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/6/5.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Common.h"


///发布地址
//#define MZBHttpURL @"http://www.mrchabo.com/"

///测试地址
#define MZBHttpURL @"http://120.25.122.11/"

///测试
//#define MZBHttpURL @"http://49.211.37.58:8082/"

@interface MZBHttpService : NSObject

+ (instancetype)shareInstance;

///获取短信验证码
- (void)getPhoneVerifyCodeWithPhoneNumber:(NSString *)phoneNumber WithBlock:(void (^)(NSNumber *result, NSError *error))block;

///登陆
- (void)loginWithPhoneNumber:(NSString *)phoneNumber andVerifiCode:(NSString *)verifiCode andBlock:(void (^)(NSDictionary *result, NSError *error))block;

///现金支付
- (void)moneyToPayWithOrderID:(NSString *)orderID andMoney:(NSString *)money WithBlock:(void (^)(NSNumber *result, NSError *error))block;

///////////////////////////////////////////////////
- (void)getHttpRequestOperationWithURLString:(NSString *)urlStr andBlock:(void (^)(NSString *responseStr, id result, NSError *error))block;

///获取分享文本内容
- (void)getShareContentWithShareUserID:(NSString *)userID andBlock:(void (^)(NSString *response, NSError *error))block;


/**
 *@function 评价阿姨
 *@param auntid-----阿姨id
 *@param orderid----订单id
 *@param totalEvaluationScore ----- 总评价的分数 有待提高为1，基本ok为2，非常满意为3
 *@param evaluationIds----问题id
 *@param evaluationScores --- 各个问题的分数（每颗星的分值为 1/星数，例如问题1点了三颗星那么问题1的得分为(1/5)*3=0.6分）
 *@param remarks -- 评价的备注
 */
- (void)commentAuntWithAuntID:(NSString *)auntID andOrderID:(NSString *)orderID andTotalEvaluationScore:(NSString *)totalEvaluationScore andEvaluationScores:(NSString *)evaluationScores andRemarks:(NSString *)remarks andBlock:(void (^)(NSDictionary *result, NSError *error))block;


///支付宝支付
- (void)apliyPayWithOutTradeNo:(NSString *)outTradeNo andTotalFee:(NSString *)totalFee andType:(NSString *)type callback:(CompletionBlock)completionBlock;

//////////////////////////////////////////////////
///获取广告列表
- (void)getHomeAdWithBlock:(void (^)(NSArray *result, NSError *error))block;

///获取主页服务
- (void)getHomeServiceWithBlock:(void (^)(NSDictionary *result, NSError *error))block;

//获取全部服务
- (void)getAllServiceWithBlock:(void (^)(NSArray *resultArray, NSError *error))block ;

///获取开通城市
- (void)getOpenCitiesWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude WithBlock:(void (^)(NSArray *resultArray, NSError *error))block;

///根据城市id获取主页服务
- (void)getHomeServiceWithCityId:(NSString *)cityId WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

//根据城市id获取全部服务
- (void)getAllServiceWithCityId:(NSString *)cityId WithBlock:(void (^)(NSArray *resultArray, NSError *error))block;

///保存地址
- (void)saveAddressWithUserId:(NSString *)userId andToken:(NSString *)token andBody:(NSData *)body WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

///获取地址列表
- (void)getAddressListWithUserId:(NSString *)userId andToken:(NSString *)token WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

////删除地址
- (void)deleteAddressWithUserId:(NSString *)userId andToken:(NSString *)token andAddressId:(NSInteger )addressId WithBlock:(void (^)(NSDictionary *result, NSError *error))block ;

////获取用户详情 当移动端需要获取用户详情（账户余额、金币余额等）时调用此接口
- (void)getUserDetaiWithUserId:(NSString *)userId andToken:(NSString *)token WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

- (void)getOrderStructWithItemId:(NSString *)itemId WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

///提交订单接口
- (void)submitOrderWithUserId:(NSString *)userId andToken:(NSString *)token andBody:(NSData *)body WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

///获取应用配置
- (void)getAppConfigWithBlock:(void (^)(NSDictionary *result, NSError *error))block;

///余额支付
- (void)paymentByBalanceWithCustomerId:(NSString *)customerId andToken:(NSString *)token andOrderId:(NSString *)orderId andPaymentAmount:(CGFloat)amount WithBlock:(void (^)(NSDictionary *result, NSError *error))block;

@end
