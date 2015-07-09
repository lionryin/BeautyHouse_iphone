//
//  ServiceAddressVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/6/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseViewController.h"

@protocol ServiceAddressVCDelegate <NSObject>

- (void)ServiceAddressVCSelectedServiceAddress:(NSString *)name andDetail:(NSString *)detail;

@end

@interface ServiceAddressVC : BaseViewController

@property (assign, nonatomic) id<ServiceAddressVCDelegate>delegate;

@end
