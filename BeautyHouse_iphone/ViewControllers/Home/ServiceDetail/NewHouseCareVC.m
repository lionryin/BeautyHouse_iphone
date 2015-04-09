//
//  NewHouseCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NewHouseCareVC.h"
#import "HouseSizeVC.h"

@interface NewHouseCareVC ()<HouseSizeVCDelete>

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

- (NSString *)spliceJsonParam{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    return [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":\"%@\",\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}", self.timeTF.text,self.houseSizeTF.text,self.moreDemondTF.text,userId,self.serviceInfo.serviceId,self.mzbAddress.addressID];

}

#pragma mark - IBAction
- (IBAction)houseSizeButtonPressed:(id)sender{
    HouseSizeVC *houseSizeVC = [[HouseSizeVC alloc] initWithNibName:@"HouseSizeVC" bundle:nil];
    houseSizeVC.delegate = self;
    houseSizeVC.houseSize = _houseSizeTF.text;
    [self.navigationController pushViewController:houseSizeVC animated:YES];
}


#pragma mark - HouseSize delegate
- (void)houseSizeVCGetHouseSize:(NSString *)hSize{
    _houseSizeTF.text = hSize;
}

@end
