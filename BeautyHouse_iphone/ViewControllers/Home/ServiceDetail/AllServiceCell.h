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

@protocol AllServiceCellDelegate <NSObject>

- (void)AllServiceCellButtonPressed:(id)sender andMzbService:(NSDictionary *)aService;

@end


@interface AllServiceCell : UITableViewCell

@property (assign, nonatomic) id<AllServiceCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet AllServiceButton *button1;
@property (weak, nonatomic) IBOutlet AllServiceButton *button2;

//@property (strong, nonatomic) MzbService *childService1;
//@property (strong, nonatomic) MzbService *childService2;
@property (strong, nonatomic) NSDictionary *childService1;
@property (strong, nonatomic) NSDictionary *childService2;

- (IBAction)buttonPressed:(id)sender;

@end
