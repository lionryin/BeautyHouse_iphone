//
//  HomeBtnCell.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButton.h"
#import "Common.h"

@protocol HomeBtnCellDelegate <NSObject>

- (void)HomeBtnCellButtonPressedWithServiceInfo:(NSDictionary *)info;

@end

@interface HomeBtnCell : UITableViewCell

@property (strong, nonatomic) NSArray *cellServices;
@property (assign, nonatomic) id<HomeBtnCellDelegate>delegate;

@property (strong, nonatomic) IBOutlet HomeButton *button1;
@property (strong, nonatomic) IBOutlet HomeButton *button2;
@property (strong, nonatomic) IBOutlet HomeButton *button3;

- (IBAction)buttonPressed:(id)sender;


@end
