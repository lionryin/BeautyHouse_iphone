//
//  CityListVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseViewController.h"

@protocol CityListVCDelegate <NSObject>

- (void)cityListVCChangedCity:(NSDictionary *)city;

@end

@interface CityListVC : BaseViewController

@property (assign, nonatomic) id<CityListVCDelegate>delegate;

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSDictionary *currentCity;

@end
