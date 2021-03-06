//
//  ChooseAddressCell.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzbAddress.h"

@interface ChooseAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *xiaoquLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;

@property (strong, nonatomic) NSDictionary *addressDic;
@property (strong, nonatomic) MzbAddress *address;

@end
