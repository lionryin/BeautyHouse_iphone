//
//  AddAddressVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddAddressVCDelegate <NSObject>

- (void)AddAddressVCAddAddressQuyu:(NSString *)quyu andXiaoqu:(NSString *)xiaoqu andDetailAddress:(NSString *)detailAddress;

@end

@interface AddAddressVC : UIViewController

@property (assign, nonatomic) id<AddAddressVCDelegate> delegate;

@end
