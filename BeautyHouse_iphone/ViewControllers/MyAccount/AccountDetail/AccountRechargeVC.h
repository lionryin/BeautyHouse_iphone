//
//  AccountRechargeVC.h
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseViewController.h"

@protocol AccountRechargeVCDelegate <NSObject>

- (void)accountRechargeVCApliyPaySuccess;

@end

@interface AccountRechargeVC : BaseViewController

@property (assign, nonatomic) id<AccountRechargeVCDelegate>delegate;

@end
