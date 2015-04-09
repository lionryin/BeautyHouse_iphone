//
//  NurseVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NurseVC.h"

@interface NurseVC ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *xingTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;

- (IBAction)xingTFClicked:(id)sender;
- (IBAction)ageTFClicked:(id)sender;

- (IBAction)sexValueChanged:(id)sender;
- (IBAction)ayMatched:(id)sender;

@end

@implementation NurseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //NSLog(@"sex:%@",( (_sexSegment.selectedSegmentIndex == 0) ? @"男" : @"女"));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)spliceJsonParam{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    NSLog(@"sex:%@",( (_sexSegment.selectedSegmentIndex == 0) ? @"男" : @"女"));
    
    return [NSString stringWithFormat:@"{\"sex\":\"%@\",\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":null,\"ageInterval\":\"%@\",\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}",( (_sexSegment.selectedSegmentIndex == 0) ? @"男" : @"女"),self.timeTF.text,self.ageTF.text,self.moreDemondTF.text,userId,self.serviceInfo.serviceId,self.mzbAddress.addressID];

}

#pragma mark - IBAction

- (IBAction)xingTFClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"一星",@"二星",@"三星",@"四星",@"五星", nil];
    actionSheet.tag = 999;
    [actionSheet showInView:self.view];
}

- (IBAction)ageTFClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"30~35",@"35~40",@"40~45", nil];
    actionSheet.tag = 1000;
    [actionSheet showInView:self.view];
}

- (IBAction)sexValueChanged:(id)sender {
    
    NSLog(@"sex:%@",( (_sexSegment.selectedSegmentIndex == 0) ? @"男" : @"女"));
}

- (IBAction)ayMatched:(id)sender {
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 999) {
        NSLog(@"%li",(long)buttonIndex);
        if (buttonIndex == 0) {
            _xingTF.text = @"一星";
        }
        else if (buttonIndex == 1){
            _xingTF.text = @"二星";
        }
        else if (buttonIndex == 2){
            _xingTF.text = @"三星";
        }
        else if (buttonIndex == 3){
            _xingTF.text = @"四星";
        }
        else if (buttonIndex == 4){
            _xingTF.text = @"五星";
        }
    }
    else if (actionSheet.tag == 1000){
        NSLog(@"%li",(long)buttonIndex);
        if (buttonIndex == 0) {
            _ageTF.text = @"30~35";
        }
        else if (buttonIndex == 1){
            _ageTF.text = @"35~40";
        }
        else if (buttonIndex == 2){
            _ageTF.text = @"40~45";
        }

    }
}

@end
