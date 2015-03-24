//
//  NewHouseCareVC.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FloorCareVC.h"

@interface NewHouseCareVC : FloorCareVC

@property (weak, nonatomic) IBOutlet UITextField *houseSizeTF;

- (IBAction)houseSizeButtonPressed:(id)sender;

@end
