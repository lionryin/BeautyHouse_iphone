//
//  FloorCareVC.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzbService.h"
#import "RMDateSelectionViewController.h"

@interface FloorCareVC : UIViewController<RMDateSelectionViewControllerDelegate>

@property (strong, nonatomic) MzbService *serviceInfo;

@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *moreDemondTF;

- (IBAction)topButtonPressed:(id)sender;
- (IBAction)timeButtonPressed:(id)sender;
- (IBAction)addressButtonPressed:(id)sender;
- (IBAction)moreDemondButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;

@end
