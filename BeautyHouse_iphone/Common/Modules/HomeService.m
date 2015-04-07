//
//  HomeService.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeService.h"
#import "GTMBase64.h"

@implementation HomeService

- (void)getHomeServiceWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block{
    
    AFHTTPRequestOperation *opration = [MZBWebService getHomePageServiceCategroy];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",resultStr);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:resultStr];
        [parser BeginToParse];
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic);
        
        ////////
        NSString *serviceResult = [dic objectForKey:@"result"];
        //NSLog(@"serviceResult:%@",serviceResult);
        
        NSArray *serviceResultInfo = [dic objectForKey:@"resultInfo"];
        
        NSMutableArray *resultMutInfo = [[NSMutableArray alloc] init];
        for (int i = 0; i<serviceResultInfo.count; i++) {
            MzbService *mzbService = [[MzbService alloc] init];
            NSDictionary *serviceDic = [serviceResultInfo objectAtIndex:i];
            
            mzbService.serviceId = [serviceDic objectForKey:@"id"];
            mzbService.serviceName = [serviceDic objectForKey:@"serviceName"];
            mzbService.servicePhoto = [serviceDic objectForKey:@"servicePhoto"];
            mzbService.serviceParentId = [serviceDic objectForKey:@"parentId"];
            mzbService.serviceDescription = [serviceDic objectForKey:@"description"];
            mzbService.serviceSign = [serviceDic objectForKey:@"sign"];
            mzbService.serviceUrllink = [serviceDic objectForKey:@"urllink"];
            mzbService.servicePriceDescription = [serviceDic objectForKey:@"priceDescription"];
            mzbService.servicePrice = [serviceDic objectForKey:@"price"];
            mzbService.childServiceCategoryList = [serviceDic objectForKey:@"childServiceCategoryList"];
            
            //NSLog(@"********\n[id:%@ \n serviceName:%@ \n servicePhoto:%@ \n parentId:%@ \n description:%@ \n sign:%@ \n urllink:%@ \n priceDescription:%@ \n price:%@]",mzbService.serviceId,mzbService.serviceName,mzbService.servicePhoto,mzbService.serviceParentId,mzbService.serviceDescription,mzbService.serviceSign,mzbService.serviceUrllink,mzbService.servicePriceDescription,mzbService.servicePrice);
            
            [resultMutInfo addObject:mzbService];
        }
        
        if (block) {
            block(serviceResult, resultMutInfo, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",[error description]);
        block(nil, nil, error);
    }];
}

- (void)getHomeAdWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block{
    AFHTTPRequestOperation *opration = [MZBWebService getHomeAppAdConfigure];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",resultStr);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:resultStr];
        [parser BeginToParse];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic);
        
        ////////
        NSString *serviceResult = [dic objectForKey:@"result"];
        //NSLog(@"serviceResult:%@",serviceResult);
        
        NSArray *serviceResultInfo = [dic objectForKey:@"resultInfo"];
        
        NSMutableArray *resultMutInfo = [[NSMutableArray alloc] init];
        for (int i = 0; i<serviceResultInfo.count; i++) {
            MzbAd *mzbAd = [[MzbAd alloc] init];
            NSDictionary *adDic = [serviceResultInfo objectAtIndex:i];
            
            mzbAd.adId = [adDic objectForKey:@"id"];
            mzbAd.adLinkUrl = [adDic objectForKey:@"adLinkUrl"];
            mzbAd.adConfigType = [adDic objectForKey:@"configType"];
            mzbAd.adDisplayIndex = [adDic objectForKey:@"displayIndex"];
            mzbAd.adImageUrl = [adDic objectForKey:@"imageUrl"];
            mzbAd.adIsVisible = [adDic objectForKey:@"isVisible"];
            mzbAd.adMemo = [adDic objectForKey:@"memo"];
            mzbAd.adTitle = [adDic objectForKey:@"title"];
            
            [resultMutInfo addObject:mzbAd];
        }
        
        if (block) {
            block(serviceResult, resultMutInfo, nil);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, nil, error);
    }];
}

- (void)getAllServiceWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block{
    AFHTTPRequestOperation *opration = [MZBWebService getAllServiceCategroyParent];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",resultStr);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:resultStr];
        [parser BeginToParse];
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        ////////
        NSString *serviceResult = [dic objectForKey:@"result"];
        //NSLog(@"serviceResult:%@",serviceResult);
        
        NSArray *serviceResultInfo = [dic objectForKey:@"resultInfo"];
        
        NSMutableArray *resultMutInfo = [[NSMutableArray alloc] init];
        for (int i = 0; i<serviceResultInfo.count; i++) {
            MzbService *mzbService = [[MzbService alloc] init];
            NSDictionary *serviceDic = [serviceResultInfo objectAtIndex:i];
            
            mzbService.serviceId = [serviceDic objectForKey:@"id"];
            mzbService.serviceName = [serviceDic objectForKey:@"serviceName"];
            mzbService.servicePhoto = [serviceDic objectForKey:@"servicePhoto"];
            mzbService.serviceParentId = [serviceDic objectForKey:@"parentId"];
            mzbService.serviceDescription = [serviceDic objectForKey:@"description"];
            mzbService.serviceSign = [serviceDic objectForKey:@"sign"];
            mzbService.serviceUrllink = [serviceDic objectForKey:@"urllink"];
            mzbService.servicePriceDescription = [serviceDic objectForKey:@"priceDescription"];
            mzbService.servicePrice = [serviceDic objectForKey:@"price"];
            
            NSArray *childList = [serviceDic objectForKey:@"childServiceCategoryList"];
            
            if (childList != nil ) {
                NSMutableArray *childArray = [[NSMutableArray alloc] init];
                for (int j = 0; j < childList.count; j++) {
                    MzbService *childService = [[MzbService alloc] init];
                    NSDictionary *childServiceDic = [childList objectAtIndex:j];
                    
                    childService.serviceId = [childServiceDic objectForKey:@"id"];
                    childService.serviceName = [childServiceDic objectForKey:@"serviceName"];
                    childService.servicePhoto = [childServiceDic objectForKey:@"servicePhoto"];
                    childService.serviceParentId = [childServiceDic objectForKey:@"parentId"];
                    childService.serviceDescription = [childServiceDic objectForKey:@"description"];
                    childService.serviceSign = [childServiceDic objectForKey:@"sign"];
                    childService.serviceUrllink = [childServiceDic objectForKey:@"urllink"];
                    childService.servicePriceDescription = [childServiceDic objectForKey:@"priceDescription"];
                    childService.servicePrice = [childServiceDic objectForKey:@"price"];
                    childService.childServiceCategoryList = [childServiceDic objectForKey:@"childServiceCategoryList"];
                    
                    [childArray addObject:childService];
                }
                mzbService.childServiceCategoryList = childArray;
            }
            
            [resultMutInfo addObject:mzbService];
            
            //NSLog(@"********\n[id:%@ \n serviceName:%@ \n servicePhoto:%@ \n parentId:%@ \n description:%@ \n sign:%@ \n urllink:%@ \n priceDescription:%@ \n price:%@]",mzbService.serviceId,mzbService.serviceName,mzbService.servicePhoto,mzbService.serviceParentId,mzbService.serviceDescription,mzbService.serviceSign,mzbService.serviceUrllink,mzbService.servicePriceDescription,mzbService.servicePrice);
            
            
        }
        
        if (block) {
            block(serviceResult, resultMutInfo, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",[error description]);
        block(nil, nil, error);
    }];
}

//提交订单
- (void)saveOrdersWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block{
    
    AFHTTPRequestOperation *opration = [MZBWebService saveOrderInfo:jsonParam];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",resultStr);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:resultStr];
        [parser BeginToParse];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",[error description]);
        block(nil, nil, error);
    }];
}

- (void)saveServiceAddressWithParam:(NSString *)jsonParam andWithBlock:(void (^)(NSString *result, NSError *error))block{
    
    AFHTTPRequestOperation *opration = [MZBWebService saveServiceAddress:jsonParam];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",resultStr);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:resultStr];
        [parser BeginToParse];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic);
        
        NSString *serviceResult = [dic objectForKey:@"result"];
        NSLog(@"addAddressServiceResult:%@",serviceResult);
        if (block) {
            block(serviceResult,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",[error description]);
        block(nil, error);
    }];

}

//替换非utf8字符
//注意：如果是三字节utf-8，第二字节错误，则先替换第一字节内容(认为此字节误码为三字节utf8的头)，然后判断剩下的两个字节是否非法；
- (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    
    return md;
}

- (void)getAllServiceAddressWihtParam:(NSString *)jsonParam andWithBlock:(void (^)(NSString *result, NSArray *resultInfo,  NSError *error))block{
    
    
    AFHTTPRequestOperation *opration = [MZBWebService getAllServiceAddress:jsonParam];

    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        //NSLog(@"data:%@",data);
        
       // NSData *newData = [self replaceNoUtf8:data];
        
       NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",resultStr);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:resultStr];
        [parser BeginToParse];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        NSString *serviceResult = [dic objectForKey:@"result"];
        NSLog(@"getAllServiceAddressResult:%@",serviceResult);
        
        NSArray *serviceResultInfo = [dic objectForKey:@"resultInfo"];
        NSMutableArray *resultMutInfo = [[NSMutableArray alloc] init];
        for (int i = 0; i<serviceResultInfo.count; i++) {
            MzbAddress *mzbAddress = [[MzbAddress alloc] init];
            NSDictionary *adDic = [serviceResultInfo objectAtIndex:i];
            
            mzbAddress.cellName = [adDic objectForKey:@"cellName"];
            mzbAddress.detailAddress = [adDic objectForKey:@"detailAddress"];
            mzbAddress.addressID = [adDic objectForKey:@"id"];
            mzbAddress.memo = [adDic objectForKey:@"memo"];
            mzbAddress.regionalInfo = [adDic objectForKey:@"regionalInfo"];
            mzbAddress.registeredUserId = [adDic objectForKey:@"registeredUserId"];
            
            [resultMutInfo addObject:mzbAddress];
        }
        
        if (block) {
            block(serviceResult, resultMutInfo, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",[error description]);
        block(nil, nil, error);
    }];
}

@end
