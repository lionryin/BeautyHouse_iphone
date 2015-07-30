//
//  CurtainCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CurtainCareVC.h"

@interface CurtainCareVC ()

@property (nonatomic) NSInteger curtainNumbers;

- (IBAction)slectCutButtonPressed:(id)sender;
- (IBAction)slectPlusButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *curtainNumTF;

@end

@implementation CurtainCareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.curtainNumbers = 1;
    [self resetCurtainNumTFWithCurtainNunbers:self.curtainNumbers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (NSString *)spliceJsonParam{
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    return [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":null,\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}", self.timeTF.text,self.moreDemondTF.text,userId,self.serviceInfo.serviceId,self.mzbAddress.addressID];
}*/

#pragma mark - 
- (void)resetCurtainNumTFWithCurtainNunbers:(NSInteger)num{
    self.curtainNumTF.text = [NSString stringWithFormat:@"%ld",(long)num
                            ];
}

#pragma mark - IBAction

- (IBAction)slectCutButtonPressed:(id)sender {
    if (self.curtainNumbers > 0) {
        [self resetCurtainNumTFWithCurtainNunbers:--self.curtainNumbers];
    }
    
}

- (IBAction)slectPlusButtonPressed:(id)sender {
    [self resetCurtainNumTFWithCurtainNunbers:++self.curtainNumbers];
}


@end
