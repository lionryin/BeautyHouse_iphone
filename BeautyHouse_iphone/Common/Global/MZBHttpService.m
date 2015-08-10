//
//  MZBHttpService.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/6/5.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MZBHttpService.h"

@implementation MZBHttpService

+ (instancetype)shareInstance
{
    static MZBHttpService *sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[MZBHttpService alloc] init];
    });
    return sharedService;
}

- (void)getPhoneVerifyCodeWithPhoneNumber:(NSString *)phoneNumber WithBlock:(void (^)(NSNumber *result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@shortmessage/service/code/verification.do?mobilePhoneNumber=%@",MZBHttpURL, phoneNumber]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    [operation start];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        //NSLog(@"html:%@",html);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        if (block) {
            block([dic objectForKey:@"status"], nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];

}

- (void)loginWithPhoneNumber:(NSString *)phoneNumber andVerifiCode:(NSString *)verifiCode andBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@login/service/code/permission.do?mobilePhoneNumber=%@&verificationCode=%@",MZBHttpURL, phoneNumber, verifiCode]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    [operation start];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        //NSLog(@"html:%@",html);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        if (block) {
            block(dic, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];

}

- (void)moneyToPayWithOrderID:(NSString *)orderID andMoney:(NSString *)money WithBlock:(void (^)(NSNumber *result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@order/Service/offlinePay.do?id=%@&deductions=%@",MZBHttpURL, orderID,money]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation start];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        //NSLog(@"html:%@",html);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        if (block) {
            block([dic objectForKey:@"result"], nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

///////////////////////////////////////////////

- (void)getHttpRequestOperationWithURLString:(NSString *)urlStr andBlock:(void (^)(NSString *responseStr, id result, NSError *error))block {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        //NSLog(@"html:%@",html);
        
        id object = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic);
        
        if (block) {
            block(html, object, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
    
}

- (void)getShareContentWithShareUserID:(NSString *)userID andBlock:(void (^)(NSString *response, NSError *error))block {
    NSString *urlStr = [NSString stringWithFormat:@"%@share/Service/getShareContent.do?shareUserId=%@", MZBHttpURL, userID];
    
    [self getHttpRequestOperationWithURLString:urlStr andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        if (block) {
            block(responseStr, error);
        }

    }];
}

/////评价阿姨
- (void)commentAuntWithAuntID:(NSString *)auntID andOrderID:(NSString *)orderID andTotalEvaluationScore:(NSString *)totalEvaluationScore andEvaluationScores:(NSString *)evaluationScores andRemarks:(NSString *)remarks andBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@Service/Order/Evaluation/add.do?auntId=%@&orderId=%@&totalEvaluationScore=%@&evaluationIds=1,2,3,4,5&evaluationScores=%@&remarks=%@",MZBHttpURL, auntID,orderID,totalEvaluationScore,evaluationScores,remarks];
    
    [self getHttpRequestOperationWithURLString:urlStr andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        if (block) {
            block(result, error);
        }
        
    }];

}


///支付宝支付
- (void)apliyPayWithOutTradeNo:(NSString *)outTradeNo andTotalFee:(NSString *)totalFee andType:(NSString *)type callback:(CompletionBlock)completionBlock{
    
    NSString *subPayInfo = [NSString stringWithFormat:@"partner=\"2088711657481475\"&seller_id=\"meizhaikeji@sina.com\"&out_trade_no=\"%@\"&subject=\"美宅宝\"&body=\"%@\"&total_fee=\"%@\"&notify_url=\"%@order/Service/alipayNotify.do\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&return_url=\"m.alipay.com\"",outTradeNo,type,totalFee,MZBHttpURL];
    
    id <DataSigner> signer = CreateRSADataSigner(RSA_PRIVATE);
    NSString *signedString = [signer signString:subPayInfo];
    
    NSString *payInfo = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",subPayInfo,signedString,@"RSA"];
    
    [[AlipaySDK defaultService] payOrder:payInfo fromScheme:@"wx038e41f97fa55586" callback:completionBlock];

    
}

///获取广告列表
- (void)getHomeAdWithBlock:(void (^)(NSArray *result, NSError *error))block {
    
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/advertisement/list.do",MZBHttpURL] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        //NSLog(@"getHomeServiceResult:%@",result);
        
        //NSArray *resultArr = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"getAllServiceResult:%@",result);
        
        if (block) {
            block(result,error);
        }

        
        
        
        
    }];

}

///获取主页服务
- (void)getHomeServiceWithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/item/list/main.do",MZBHttpURL] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        NSLog(@"getHomeServiceResult:%@",result);
        if (block) {
            block(result,error);
        }
        
    }];
}

//获取全部服务
- (void)getAllServiceWithBlock:(void (^)(NSArray *resultArray, NSError *error))block {
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/item/category/list.do",MZBHttpURL] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        //NSLog(@"getAllServiceResult:%@",responseStr);
        //NSArray *resultArr = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"getAllServiceResult:%@",result);
        
        if (block) {
            block(result,error);
        }

    }];
}

///获取开通城市
- (void)getOpenCitiesWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude WithBlock:(void (^)(NSArray *resultArray, NSError *error))block {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/citys/open.do?longitude=%f&latitude=%f",MZBHttpURL,longitude,latitude];
    [self getHttpRequestOperationWithURLString:urlStr andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        //NSArray *resultArr = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"getOpenCities:%@",result);
        
        if (block) {
            block(result,error);
        }

        
    }];
    
}

///根据城市id获取主页服务
- (void)getHomeServiceWithCityId:(NSString *)cityId WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/item/list/main.do?city_id=%@",MZBHttpURL,cityId] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        NSLog(@"getHomeServiceResult:%@",result);
        if (block) {
            block(result,error);
        }
        
    }];
}

//根据城市id获取全部服务
- (void)getAllServiceWithCityId:(NSString *)cityId WithBlock:(void (^)(NSArray *resultArray, NSError *error))block {
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/item/category/list.do?city_id=%@",MZBHttpURL,cityId] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        //NSLog(@"getAllServiceResult:%@",responseStr);
        //NSArray *resultArr = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"getAllServiceResult:%@",result);
        
        if (block) {
            block(result,error);
        }
        
    }];
}

///保存地址
- (void)saveAddressWithUserId:(NSString *)userId andToken:(NSString *)token andBody:(NSData *)body WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@address/add.do?user_id=%@&token=%@",MZBHttpURL,userId,token]]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:body];

    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"html:%@",[responseObject description]);
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error:%@",[error description]);
        block(nil, error);
        
    }];
}

///获取地址列表
- (void)getAddressListWithUserId:(NSString *)userId andToken:(NSString *)token WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@address/list.do?user_id=%@&token=%@",MZBHttpURL,userId,token] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        NSLog(@"getAddressListResult:%@",responseStr);
        if (block) {
            block(result,error);
        }
    }];
}

////删除地址
- (void)deleteAddressWithUserId:(NSString *)userId andToken:(NSString *)token andAddressId:(NSInteger )addressId WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    /*[self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/address.do?user_id=%@&token=%@&address_id=%li",MZBHttpURL,userId,token,(long)addressId] andBlock:^(NSString *responseStr, NSDictionary *result, NSError *error) {
        
        NSLog(@"deleteAddressResult:%@",result);
        if (block) {
            block(result,error);
        }
    }];*/
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@api/address.do?user_id=%@&token=%@&address_id=%li",MZBHttpURL,userId,token,(long)addressId]]];
    [request setHTTPMethod:@"DELETE"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
    
    //operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"html:%@",[responseObject description]);
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error:%@",[error description]);
        block(nil, error);
        
    }];
}

////获取用户详情 当移动端需要获取用户详情（账户余额、金币余额等）时调用此接口
- (void)getUserDetaiWithUserId:(NSString *)userId andToken:(NSString *)token WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/user/detail.do?user_id=%@&token=%@",MZBHttpURL,userId,token] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        NSLog(@"getUserDetaiResult:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}


///获取商品下单组建 当移动端需要对单一商品进行下单操作时调用此接口
- (void)getOrderStructWithItemId:(NSString *)itemId WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/order/item/parameter.do?item_id=%@",MZBHttpURL,itemId] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        NSLog(@"getOrderStructResult:%@",result);
        if (block) {
            block(result,error);
        }
    }];

}

///提交订单接口
- (void)submitOrderWithUserId:(NSString *)userId andToken:(NSString *)token andBody:(NSData *)body WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@api/order.do?user_id=%@&token=%@",MZBHttpURL,userId,token]]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:body];
    
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"html:%@",[responseObject description]);
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error:%@",[error description]);
        block(nil, error);
        
    }];

}

///获取应用配置
- (void)getAppConfigWithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    [self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/app/config.do",MZBHttpURL] andBlock:^(NSString *responseStr, id result, NSError *error) {
        NSLog(@"getAppConfigResult:%@",result);
        if (block) {
            block(result,error);
        }

    }];
}

///余额支付
- (void)paymentByBalanceWithCustomerId:(NSString *)customerId andToken:(NSString *)token andOrderId:(NSString *)orderId andPaymentAmount:(CGFloat)amount WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    /*[self getHttpRequestOperationWithURLString:[NSString stringWithFormat:@"%@api/order/payment/balance.do?customer_id=%@&token=%@&order_id=%@&payment_amount=%f",MZBHttpURL,customerId,token,orderId,amount] andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        if (block) {
            block(result,error);
        }
    }];*/
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@api/order/payment/balance.do?customer_id=%@&token=%@&order_id=%@&payment_amount=%f",MZBHttpURL,customerId,token,orderId,amount]]];
    [request setHTTPMethod:@"PUT"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"html:%@",[responseObject description]);
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error:%@",[error description]);
        block(nil, error);
        
    }];

}

///获取订单列表
- (void)getOrderListWithUserId:(NSString *)userId andToken:(NSString *)token andNextPageIndex:(NSString *)nextPageIndex andOrderStatusCode:(NSString *)statusCode WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/order/page/reduced.do?user_id=%@&token=%@&next_page_index=%@&order_status_code=%@",MZBHttpURL,userId,token,nextPageIndex,statusCode];
    
    NSLog(@"urlStr:%@",urlStr);
    
    [self getHttpRequestOperationWithURLString:urlStr andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        if (block) {
            block(result,error);
        }
    }];
}

/**
 *  取消订单
 */
- (void)cancelOrderWithUserId:(NSString *)userId andToken:(NSString *)token andOrderId:(NSString *)orderId WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@order/cancelOrder.do?user_id=%@&token=%@&orderId=%@",MZBHttpURL,userId,token,orderId];
    
    //NSLog(@"urlStr:%@",urlStr);
    
    [self getHttpRequestOperationWithURLString:urlStr andBlock:^(NSString *responseStr, id result, NSError *error) {
        
        if (block) {
            block(result,error);
        }
    }];

}

@end
