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

#define imageURLPrefix @"http://218.244.143.58/beautiHouse/"

@interface MZBWebService : NSObject

+ (AFHTTPRequestOperation *)getHomePageServiceCategroy;

+ (AFHTTPRequestOperation *)MZBWebService:(NSString *)body;

+ (AFHTTPRequestOperation *)getCurrentOrderListWithParameter:(NSString *)param;



@end
