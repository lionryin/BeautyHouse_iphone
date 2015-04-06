//
//  ChooseAddressVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzbAddress.h"

@protocol ChooseAddressVCDelegate <NSObject>

- (void)chooseAddressVCCellSelected:(MzbAddress *)address;

@end

@interface ChooseAddressVC : UIViewController

@property (assign, nonatomic) id<ChooseAddressVCDelegate>delegate;

@end
