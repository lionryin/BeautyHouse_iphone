//
//  FloorCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FloorCareVC.h"
#import "ServiceIntroductionVC.h"

#import "LoginVC.h"

@interface FloorCareVC ()

@end

@implementation FloorCareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = _serviceInfo.serviceName;
    [_topButton setTitle:_serviceInfo.servicePriceDescription forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction
- (IBAction)topButtonPressed:(id)sender{
    ServiceIntroductionVC *introductionVC = [[ServiceIntroductionVC alloc] initWithNibName:@"ServiceIntroductionVC" bundle:nil];
    introductionVC.urlStr = [NSString stringWithFormat:@"%@%@",imageURLPrefix,_serviceInfo.serviceUrllink];
    [self.navigationController pushViewController:introductionVC animated:YES];
}

- (IBAction)timeButtonPressed:(id)sender{
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    [dateSelectionVC show];
    
    //After -[RMDateSelectionViewController show] or -[RMDateSelectionViewController showFromViewController:] has been called you can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minimumDate = [NSDate date];
    dateSelectionVC.datePicker.minuteInterval = 10;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
}

- (IBAction)addressButtonPressed:(id)sender{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userIsLogin = [userDic objectForKey:UserIsLoginKey];
    
    if ([userIsLogin isEqualToString:@"0"]) {//未登陆
        LoginVC *loginVC = [[LoginVC alloc]init];
        UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
    else{
        ChooseAddressVC *chooseAddressVC = [[ChooseAddressVC alloc] init];
        chooseAddressVC.delegate = self;
        [self.navigationController pushViewController:chooseAddressVC animated:YES];

    }
}
- (IBAction)moreDemondButtonPressed:(id)sender{
    MoreDemandVC *moreDemandVC = [[MoreDemandVC alloc] initWithNibName:@"MoreDemandVC" bundle:nil];
    moreDemandVC.delegate = self;
    moreDemandVC.moreDemand = _moreDemondTF.text;
    [self.navigationController pushViewController:moreDemandVC animated:YES];
}

- (IBAction)submitButtonPressed:(id)sender{
    
}

#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yy-MM-dd eee HH:mm";
    NSString *timeStr=[formatter stringFromDate:aDate];
    NSLog(@"Successfully selected date: %@", timeStr);
    
    self.timeTF.text = timeStr;
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}

#pragma mark - ChooseAddressVC delegate
- (void)chooseAddressVCCellSelected:(NSDictionary *)dic{
    
    self.addressTF.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"xq"],[dic objectForKey:@"detail"]];
}

#pragma mark - MoreDemandVC Delegate
- (void)moreDemandVCGetDemand:(NSString *)demand{
    self.moreDemondTF.text = demand;
}

@end
