//
//  UserGuidVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CitiesBlock)(NSArray *resultArray, NSError *error);

@interface UserGuidVC : UIViewController

@property (strong, nonatomic) CitiesBlock citiesBlock;
- (void)getCities:(CitiesBlock)block;

@end
