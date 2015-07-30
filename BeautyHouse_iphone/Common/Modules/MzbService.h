//
//  MzbService.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZBWebService.h"

@interface MzbService : NSObject

@property (strong, nonatomic) NSString *serviceId;
@property (strong, nonatomic) NSString *serviceName;
@property (strong, nonatomic) NSString *servicePhoto;
@property (strong, nonatomic) NSString *serviceParentId;
@property (strong, nonatomic) NSString *serviceDescription;
@property (strong, nonatomic) NSString *serviceSign;
@property (strong, nonatomic) NSString *serviceUrllink;
@property (strong, nonatomic) NSString *servicePriceDescription;
@property (strong, nonatomic) NSString *servicePrice;
@property (strong, nonatomic) NSArray *childServiceCategoryList;


@end
