//
//  HomeService.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeService.h"

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
        NSLog(@"serviceResult:%@",serviceResult);
        
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
            
            NSLog(@"********\n[id:%@ \n serviceName:%@ \n servicePhoto:%@ \n parentId:%@ \n description:%@ \n sign:%@ \n urllink:%@ \n priceDescription:%@ \n price:%@]",mzbService.serviceId,mzbService.serviceName,mzbService.servicePhoto,mzbService.serviceParentId,mzbService.serviceDescription,mzbService.serviceSign,mzbService.serviceUrllink,mzbService.servicePriceDescription,mzbService.servicePrice);
            
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

@end
