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

@interface MZBHttpService : NSObject

+ (instancetype)shareInstance;

///获取短信验证码
- (void)getPhoneVerifyCodeWithPhoneNumber:(NSString *)phoneNumber WithBlock:(void (^)(NSNumber *result, NSError *error))block;

///登陆
- (void)loginWithPhoneNumber:(NSString *)phoneNumber andVerifiCode:(NSString *)verifiCode andBlock:(void (^)(NSDictionary *result, NSError *error))block;

///现金支付
- (void)moneyToPayWithOrderID:(NSString *)orderID andMoney:(NSString *)money WithBlock:(void (^)(NSNumber *result, NSError *error))block;

///////////////////////////////////////////////////
- (void)getHttpRequestOperationWithURLString:(NSString *)urlStr andBlock:(void (^)(NSString *responseStr, NSDictionary *result, NSError *error))block;

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
- (void)apliyPayWithOutTradeNo:(NSString *)outTradeNo andTotalFee:(NSString *)totalFee callback:(CompletionBlock)completionBlock;

@end
