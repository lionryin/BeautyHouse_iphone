//
//  HomeService.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MzbService.h"
#import "MzbAd.h"

@interface HomeService : NSObject

//@property (strong, nonatomic) NSString *result;
//@property (strong, nonatomic) NSArray *resultInfo;

//获取主页服务
- (void)getHomeServiceWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block;

//获取主页广告
- (void)getHomeAdWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block;

//获取全部服务
- (void)getAllServiceWithBlock:(void (^)(NSString *result, NSArray *resultInfo, NSError *error))block;


@end
