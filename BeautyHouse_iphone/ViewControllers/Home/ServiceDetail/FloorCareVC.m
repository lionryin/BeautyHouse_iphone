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
#import "SaveOrderSuccessVC.h"


@interface FloorCareVC ()<UIAlertViewDelegate>

@property (strong, nonatomic) MBProgressHUD *hud;



@end

@implementation FloorCareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = _serviceInfo[@"name"];
    [_topButton setTitle:_serviceInfo[@"price_decr"] forState:UIControlStateNormal];
    
    //[self getOrderStruct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction
- (IBAction)topButtonPressed:(id)sender{
   /* ServiceIntroductionVC *introductionVC = [[ServiceIntroductionVC alloc] initWithNibName:@"ServiceIntroductionVC" bundle:nil];
    introductionVC.urlStr = [NSString stringWithFormat:@"%@%@",imageURLPrefix,_serviceInfo.serviceUrllink];
    [self.navigationController pushViewController:introductionVC animated:YES];*/
}

- (IBAction)timeButtonPressed:(id)sender{
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    [dateSelectionVC show];
    
    //After -[RMDateSelectionViewController show] or -[RMDateSelectionViewController showFromViewController:] has been called you can access the actual UIDatePicker via the datePicker property
   /* dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minimumDate = [NSDate date];
    dateSelectionVC.datePicker.minuteInterval = 10;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];*/
}

- (IBAction)addressButtonPressed:(id)sender{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userIsLogin = [userDic objectForKey:UserIsLoginKey];
    
    if ([userIsLogin isEqualToString:@"0"]) {//未登陆
        LoginVC *loginVC = [[LoginVC alloc]init];
        loginVC.isOrderFrom = NO;
        UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
    else{
//        ChooseAddressVC *chooseAddressVC = [[ChooseAddressVC alloc] init];
//        chooseAddressVC.delegate = self;
//        [self.navigationController pushViewController:chooseAddressVC animated:YES];
        ServiceAddressVC *vc = [[ServiceAddressVC alloc] initWithNibName:@"ServiceAddressVC" bundle:nil];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];

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
        [self submitOrder];
        /*_hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        _hud.labelText = @"提交中...";
        [self.navigationController.view addSubview:_hud];
        [_hud show:YES];
        
        HomeService *homeService = [[HomeService alloc] init];
        [homeService saveOrdersWithParam:[self spliceJsonParam] andWithBlock:^(NSNumber *result, NSString *orderID, NSError *error) {
            
            [_hud hide:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else{
                    if ([result integerValue] == 0) {
                        
                        MyOrderVO *myOrder = [[MyOrderVO alloc] init];
                        myOrder.title = self.serviceInfo[@"name"];
                        myOrder.time = self.timeTF.text;
                        myOrder.address = [NSString stringWithFormat:@"%@ %@",self.mzbAddress.cellName,self.mzbAddress.detailAddress];
                        myOrder.orderID = orderID;
                        
                        SaveOrderSuccessVC *saveOrderSuccessVC = [[SaveOrderSuccessVC alloc] initWithNibName:@"SaveOrderSuccessVC" bundle:nil];
                        saveOrderSuccessVC.order = myOrder;
                        //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:saveOrderSuccessVC];
                        //[self presentViewController:nav animated:YES completion:^{
                            //[self.navigationController popViewControllerAnimated:YES];
                        //}];
                        
                        [self.navigationController pushViewController:saveOrderSuccessVC animated:YES];

                    }
                    else{
                        
                    }
                    
                    
                }

            });
        }];*/

    }
}

- (void)getOrderStruct {
    [[MZBHttpService shareInstance] getOrderStructWithItemId:_serviceInfo[@"id"] WithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *status = result[@"status"];
            if (status.boolValue) {
                NSString *dataStr = result[@"data"];
            
                NSLog(@"dataStr:%@",dataStr);
                
                
            }
            else {
                
            }
        }
        else {
            
        }
    }];
}

- (void)submitOrder {
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSString *token = [userDic objectForKey:UserToken];
    
    //NSString *bodyStr = [NSString stringWithFormat:@"{\"user_id\":\"%@\",\"item_id\":\"%@\",\"platform_code\":\"IOS\",\"order_parameters\":\"[%@]\"}",userId,_serviceInfo[@"id"],[self spliceJsonParam]];
    //NSLog(@"bodyStr:%@",bodyStr);
    //NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = @{@"user_id":userId, @"item_id":_serviceInfo[@"id"], @"platform_code":@"IOS", @"order_parameters":[self getOrderParameters]};
    
    //NSData *body = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONReadingAllowFragments error:nil ];
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"body:%@",[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    
    _hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    _hud.labelText = @"提交中...";
    [self.navigationController.view addSubview:_hud];
    [_hud show:YES];
    [[MZBHttpService shareInstance] submitOrderWithUserId:userId andToken:token andBody:body WithBlock:^(NSDictionary *result, NSError *error) {
        
        
        if (!error) {
            NSNumber *status = result[@"status"];
            if (status.boolValue) {
                
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"提交成功";
                [_hud hide:YES afterDelay:2.0];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                [_hud hide:YES];
                [UIFactory showAlert:@"发生错误"];
            }
        }
        else {
            [_hud hide:YES];
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}

- (NSArray *)getOrderParameters {
    NSMutableArray *arr = [NSMutableArray array];
    
    NSString *timeStr = self.timeTF.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM--dd HH:mm:ss"];
    NSDate *time = [formatter dateFromString:timeStr];
    
    NSLog(@"time:%@",time);
    
    CGFloat floatTimeSp = [time timeIntervalSince1970]*1000;
    

    NSString *timeSp = [NSString stringWithFormat:@"%.0f",floatTimeSp];
    
    NSLog(@"floatTimeSp:%f\n timeSp:%@",floatTimeSp,timeSp);
    
    NSDictionary *dic1 = @{@"value":timeSp, @"id":@"1"};
    [arr addObject:dic1];
    
    NSString *addressId = @"";
    if (self.selectedAddress) {
        if (self.selectedAddress[@"id"]) {
            addressId = self.selectedAddress[@"id"];
        }
    }
    
    NSLog(@"addressId:%@",addressId);
    
    NSDictionary *dic2 = @{@"value":addressId, @"id":@"2"};
    [arr addObject:dic2];
    
    NSDictionary *dic3 = @{@"value":self.moreDemondTF.text, @"id":@"3"};
    [arr addObject:dic3];
    
    
    
    return arr;
}

- (NSString *)spliceJsonParam{
    
    /*NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    return [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":null,\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}", self.timeTF.text,self.moreDemondTF.text,userId,self.serviceInfo[@"id"],self.mzbAddress.addressID];*/
    return [NSString stringWithFormat:@"{\"id\":\"1\",\"value\":\"%@\"},{\"id\":\"2\",\"value\":\"%@\"},{\"id\":\"3\",\"value\":\"%@\"}",self.timeTF.text, self.addressTF.text, self.moreDemondTF.text];
    
}

#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSString *)aDate {
    
    /*NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yy-MM-dd HH:mm:ss";
    NSString *timeStr=[formatter stringFromDate:aDate];
    NSLog(@"Successfully selected date: %@", timeStr);*/
    
    self.timeTF.text = aDate;
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

#pragma mark - ServiceAddress delegate
- (void)ServiceAddressVCSelectedServiceAddress:(NSDictionary *)address {
    
    self.addressTF.text = [NSString stringWithFormat:@"%@ %@",address[@"name"],address[@"detail"]];
    self.selectedAddress = address;
}

@end
