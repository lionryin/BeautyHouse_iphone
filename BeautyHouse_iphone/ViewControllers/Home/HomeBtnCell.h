//
//  HomeBtnCell.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButton.h"

@protocol HomeBtnCellDelegate <NSObject>

- (void)HomeBtnCellButtonPressed:(id)sender andServiceInfos:(NSArray *)infos;

@end

@interface HomeBtnCell : UITableViewCell

@property (strong, nonatomic) NSArray *serviceInfos;
@property (assign, nonatomic) id<HomeBtnCellDelegate>delegate;

@property (strong, nonatomic) IBOutlet HomeButton *button1;
@property (strong, nonatomic) IBOutlet HomeButton *button2;
@property (strong, nonatomic) IBOutlet HomeButton *button3;
@property (strong, nonatomic) IBOutlet HomeButton *button4;
@property (strong, nonatomic) IBOutlet HomeButton *button5;
@property (strong, nonatomic) IBOutlet HomeButton *button6;
@property (strong, nonatomic) IBOutlet HomeButton *button7;
@property (strong, nonatomic) IBOutlet HomeButton *button8;
@property (strong, nonatomic) IBOutlet HomeButton *button9;

- (IBAction)buttonPressed:(id)sender;


@end
