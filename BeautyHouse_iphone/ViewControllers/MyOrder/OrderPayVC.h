//
//  OrderPayVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderVO.h"

@interface OrderPayVC : UIViewController

@property (strong, nonatomic) MyOrderVO *orderVO;

- (IBAction)nextStepButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *rmbTF;

@end
