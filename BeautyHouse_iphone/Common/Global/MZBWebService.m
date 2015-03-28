//
//  WebService.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MZBWebService.h"

@implementation MZBWebService


+ (AFHTTPRequestOperation *)MZBWebService:(NSString *)body{
    
    NSURL* WebURL = [NSURL URLWithString:MZBWebURL];
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] init];
    [req setURL:WebURL];
    [req setHTTPMethod:@"POST"];
    [req addValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    NSMutableData* postbody = [[NSMutableData alloc] init];
    [postbody appendData:[[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.houseWs.ereal.com/\"><soapenv:Header/><soapenv:Body>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"%@",body] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"</soapenv:Body></soapenv:Envelope>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPBody:postbody];
    
    
    NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:NSUTF8StringEncoding];
    NSLog(@"requestURL:%@",requestURL);
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    return opration;

}

+ (AFHTTPRequestOperation *)getHomePageServiceCategroy
{
    return [MZBWebService MZBWebService:@"<ws:getHomePageServiceCategroy/>"];
    
}



+ (AFHTTPRequestOperation *)getHomeAppAdConfigure{
    
    return [MZBWebService MZBWebService:@"<ws:getHomeAppAdConfigure/>"];
}

+ (AFHTTPRequestOperation *)getAllServiceCategroyParent{
    return [MZBWebService MZBWebService:@"<ws:getAllServiceCategroyParent/>"];
}


#pragma mark - Login
+ (AFHTTPRequestOperation *)getPhoneVerifyCode:(NSString *)jsonParam{
    NSString *params = [NSString stringWithFormat:@"<ws:sendCode><registeredUserJson>%@</registeredUserJson></ws:sendCode>",jsonParam];
    
    return [MZBWebService MZBWebService:params];
    
}

+ (AFHTTPRequestOperation *)login:(NSString *)jsonParam{
    
    NSString *params = [NSString stringWithFormat:@"<ws:login><registeredUserJson>%@</registeredUserJson></ws:login>",jsonParam];
    
    return [MZBWebService MZBWebService:params];
}





#pragma mark - Order
+ (AFHTTPRequestOperation *)getCurrentOrderListWithParameter:(NSString *)jsonParam{
    
    
    NSString *params = [NSString stringWithFormat:@"<ws:getPageByOrderInfo><pageQueryJson>%@</pageQueryJson></ws:getPageByOrderInfo>",jsonParam];
    
    return [MZBWebService MZBWebService:params];
}




#pragma mark - My Account




#pragma mark - Member Center





@end
