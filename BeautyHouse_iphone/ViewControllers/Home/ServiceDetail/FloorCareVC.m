//
//  FloorCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FloorCareVC.h"
#import "ServiceIntroductionVC.h"

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
    
}
- (IBAction)moreDemondButtonPressed:(id)sender{
    
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


@end
