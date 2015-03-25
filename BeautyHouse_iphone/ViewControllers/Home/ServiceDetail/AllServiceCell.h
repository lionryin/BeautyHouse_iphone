//
//  AllServiceCell.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzbService.h"
#import "AllServiceButton.h"

@interface AllServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AllServiceButton *button1;
@property (weak, nonatomic) IBOutlet AllServiceButton *button2;

@property (strong, nonatomic) MzbService *childService1;
@property (strong, nonatomic) MzbService *childService2;

@end
