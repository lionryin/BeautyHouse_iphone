//
//  OrderPayVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderVO.h"

@protocol OrderPayVCDelegate <NSObject>

- (void)orderPayVCPaySuccess;

@end

@interface OrderPayVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;

@property (nonatomic, assign) id<OrderPayVCDelegate>delegate;

@property (strong, nonatomic) MyOrderVO *orderVO;
@property (strong, nonatomic) NSDictionary *orderItem;

- (IBAction)nextStepButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *rmbTF;

@end
