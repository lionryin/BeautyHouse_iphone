//
//  AppDelegate.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

typedef void (^CitiesBlock)(NSArray *resultArray, NSError *error);

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CitiesBlock citiesBlock;
- (void)getCities:(CitiesBlock)block;
//@property (strong, nonatomic) NSArray *cities;


@end

