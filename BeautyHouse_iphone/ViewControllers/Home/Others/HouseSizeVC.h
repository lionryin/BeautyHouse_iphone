//
//  HouseSizeVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HouseSizeVCDelete <NSObject>

- (void)houseSizeVCGetHouseSize:(NSString *)hSize;

@end

@interface HouseSizeVC : UIViewController

@property (assign, nonatomic) id<HouseSizeVCDelete>delegate;

@property (strong, nonatomic) NSString *houseSize;



@end
