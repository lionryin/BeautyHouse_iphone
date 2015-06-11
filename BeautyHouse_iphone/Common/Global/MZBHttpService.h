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

///支付宝支付
- (void)apliyPayWithOutTradeNo:(NSString *)outTradeNo andTotalFee:(NSString *)totalFee callback:(CompletionBlock)completionBlock;

@end
