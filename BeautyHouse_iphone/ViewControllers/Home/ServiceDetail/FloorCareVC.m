//
//  FloorCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FloorCareVC.h"
#import "ServiceIntroductionVC.h"
#import "HomeService.h"
#import "LoginVC.h"

@interface FloorCareVC ()<UIAlertViewDelegate>

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
    
    if (self.timeTF.text.length <=0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"预约时间不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        return;
        
    }else if (self.addressTF.text.length <= 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务地址不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
        
    }else{
       
        HomeService *homeService = [[HomeService alloc] init];
        [homeService saveOrdersWithParam:[self spliceJsonParam] andWithBlock:^(NSString *result, NSArray *resultInfo, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单提交成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    alert.tag = 999;
                    [alert show];
                }

            });
            
            
        }];

    }
}

- (NSString *)spliceJsonParam{
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    return [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":null,\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}", self.timeTF.text,self.moreDemondTF.text,userId,self.serviceInfo.serviceId,self.mzbAddress.addressID];
    
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
- (void)chooseAddressVCCellSelected:(MzbAddress *)address{
    self.mzbAddress = address;
    self.addressTF.text = [NSString stringWithFormat:@"%@ %@",address.cellName,address.detailAddress];
}

#pragma mark - MoreDemandVC Delegate
- (void)moreDemandVCGetDemand:(NSString *)demand{
    self.moreDemondTF.text = demand;
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 999) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
