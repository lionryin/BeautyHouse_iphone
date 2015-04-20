//
//  Alipay.h
//  AlipayGateway
//
//  Created by 方彬 on 11/7/13.
//  Copyright (c) 2013 Alipay.com. All rights reserved.
//

////////////////////////////////////////////////////////////////
/////////////  SDK 2.3 motify:09/09/14  ////////////////////////
////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "APAuthInfo.h"

typedef void(^PaymentCallbackBlock)(NSString *resultStr);

typedef void(^AuthCompletionBlock)(NSDictionary *resultDic);

@interface Alipay : NSObject

/**
 *	PayService单例
 *
 *	@return	单例对象
 */
+ (Alipay *)defaultService;

- (void)preLoad;



/**
 *  调用支付宝支付接口
 *
 *  @param orderStr      订单信息字符串
 *  @param schemeStr     调用方应用scheme
 *  @param callbackBlock 支付结果信息回调
 */
- (void)pay:(NSString *)orderStr from:(NSString *)schemeStr callback:(PaymentCallbackBlock)callbackBlock;


/**
 *  处理外调支付宝钱包支付完成回调结果回传（仅当支付不能通过极简收银台完成）
 *
 *  @param orderUrl 在UIApplicationDelegate中application:openURL:sourceApplication:annotation:将url传给SDK处理
 */
- (void)processPayResultFromAlipayclientWithOrder:(NSURL *)orderUrl;

/**
 *  当收银台存在则隐藏,当商户app在收银台过程中插入其他任务，可以调用暂时隐藏
 */
- (void)hideCashierIfExist;


/**
 *  当收银台存在则显示，如果之前隐藏的收银台，在任务完成后调用重新显示
 */
- (void)showCashierIfExist;


/**
 *  查询账号是否存在
 *
 *  @return 如果存在返回YES，反之
 */
- (void)checkAccountIfExist:(void(^)(BOOL isExist))checkResultBlock;


- (void)setUrl:(NSString *)url;


//二期

/**
 *  卡管理
 *
 *  @param infoStr          调用方信息
 *  @param cardManagerBlock 界面回调，由调用方处理显示问题
 */
- (void)cardManagerWithInfo:(NSString *)infoStr;

/**
 *  预链接接口
 */
- (void)createLiveConnection;

- (void)seeding:(NSDictionary*)dict;


/**
 *  快登授权
 *  @param authInfo        需授权信息
 *  @param completionBlock 授权结果回调
 */
- (void) authWithInfo:(APAuthInfo *)authInfo
             callback:(AuthCompletionBlock)completionBlock;

/**
 *  处理授权信息Url
 *
 *  @param resultUrl 钱包返回的授权结果url
 */
- (void)processAuthResult:(NSURL *)resultUrl;


- (NSString*)getSDKVersionInfo;
@end
