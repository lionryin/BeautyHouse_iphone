//
//  HomeTableVC.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBtnCell.h"

@interface HomeTableVC : UITableViewController<HomeBtnCellDelegate>
///test sync test sync

@property (strong, nonatomic) NSArray *serviceInfos;
@property (strong, nonatomic) NSArray *adInfos;

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSDictionary *currentCity;

- (IBAction)phoneClicked:(id)sender;
- (IBAction)cityClicked:(id)sender;

- (void)getCities;


@end
