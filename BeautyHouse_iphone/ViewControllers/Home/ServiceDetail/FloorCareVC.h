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
#import "ChooseAddressVC.h"
#import "MoreDemandVC.h"
#import "MzbAddress.h"
#import "MBProgressHUD.h"
#import "ServiceAddressVC.h"

@interface FloorCareVC : UIViewController<RMDateSelectionViewControllerDelegate,ChooseAddressVCDelegate, MoreDemandVCDelegate, ServiceAddressVCDelegate>

@property (strong, nonatomic) NSDictionary *serviceInfo;

@property (strong, nonatomic) MzbAddress *mzbAddress;

@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextView *moreDemondTF;
@property (weak, nonatomic) IBOutlet UILabel *tsLabel;

- (IBAction)topButtonPressed:(id)sender;
- (IBAction)timeButtonPressed:(id)sender;
- (IBAction)addressButtonPressed:(id)sender;
- (IBAction)moreDemondButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;

@property (strong, nonatomic) NSDictionary *selectedAddress;
- (void)submitOrder;
- (NSArray *)getOrderParameters ;
- (NSString *)spliceJsonParam;

-(void) slideFrame:(BOOL)up;

@end
