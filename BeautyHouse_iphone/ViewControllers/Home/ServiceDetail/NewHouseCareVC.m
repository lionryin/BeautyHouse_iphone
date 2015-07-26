//
//  NewHouseCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NewHouseCareVC.h"
#import "HouseSizeVC.h"

@interface NewHouseCareVC ()<HouseSizeVCDelete, UITextFieldDelegate>

@end

@implementation NewHouseCareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getOrderParameters {
    NSMutableArray *arr = [NSMutableArray array];
    
    NSString *timeStr = self.timeTF.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM--dd HH:mm:ss"];
    NSDate *time = [formatter dateFromString:timeStr];
    
    int timeSp = [time timeIntervalSince1970];
    
    NSLog(@"timeSp:%i",timeSp);
    
    NSDictionary *dic1 = @{@"value":[NSNumber numberWithInt:timeSp], @"id":@"1"};
    [arr addObject:dic1];
    
    NSString *addressId = @"";
    if (self.selectedAddress) {
        if (self.selectedAddress[@"id"]) {
            addressId = self.selectedAddress[@"id"];
        }
    }
    
    NSDictionary *dic2 = @{@"value":addressId, @"id":@"2"};
    [arr addObject:dic2];
    
    NSDictionary *dic3 = @{@"value":self.moreDemondTF.text, @"id":@"3"};
    [arr addObject:dic3];
    
    NSDictionary *dic4 = @{@"value":self.houseSizeTF.text, @"id":@"4"};
    [arr addObject:dic4];
    
    return arr;
}


- (NSString *)spliceJsonParam{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    return [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":\"%@\",\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}", self.timeTF.text,self.houseSizeTF.text,self.moreDemondTF.text,userId,self.serviceInfo[@"id"],self.mzbAddress.addressID];

}

#pragma mark - IBAction
- (IBAction)houseSizeButtonPressed:(id)sender{
    HouseSizeVC *houseSizeVC = [[HouseSizeVC alloc] initWithNibName:@"HouseSizeVC" bundle:nil];
    houseSizeVC.delegate = self;
    houseSizeVC.houseSize = _houseSizeTF.text;
    [self.navigationController pushViewController:houseSizeVC animated:YES];
}

- (IBAction)submitButtonPressed:(id)sender {
    
    if (self.timeTF.text.length <=0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"预约时间不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        return;
        
    }else if (self.addressTF.text.length <= 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务地址不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
        
    }else if (self.houseSizeTF.text.length <= 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"房屋面积不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    else{
        [self submitOrder];
    }
}


#pragma mark - HouseSize delegate
- (void)houseSizeVCGetHouseSize:(NSString *)hSize{
    _houseSizeTF.text = hSize;
}

#pragma mark - textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self slideFrame:YES ];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self slideFrame:NO ];
}


@end
