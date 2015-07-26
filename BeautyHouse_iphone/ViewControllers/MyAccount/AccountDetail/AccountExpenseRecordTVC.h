//
//  AccountExpenseRecordTVC.h
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountExpenseRecordTVC : UITableViewCell

@property (strong, nonatomic) NSDictionary *resultInfo;

- (void)updateCellWithDictionary:(NSDictionary *)dic;
@end
