//
//  AddAddressVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AddAddressVC.h"
#import "QuyuVC.h"
#import "HomeService.h"

@interface AddAddressVC ()<QuyuVCDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *quyuTF;
- (IBAction)quyuButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *xiaoquTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;
- (IBAction)querenButtonClicked:(id)sender;

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加服务地址";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_xiaoquTF resignFirstResponder];
    [_detailAddressTF resignFirstResponder];
}

#pragma mark - IBAction
- (IBAction)quyuButtonClicked:(id)sender {
    QuyuVC *quyuVC = [[QuyuVC alloc] init];
    quyuVC.delegate = self;
    [self.navigationController pushViewController:quyuVC animated:YES];
}

- (IBAction)querenButtonClicked:(id)sender {
    
    if (_quyuTF.text == nil || [_quyuTF.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择一个区域" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_xiaoquTF.text == nil || [_xiaoquTF.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入小区名称" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_detailAddressTF.text == nil || [_detailAddressTF.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入详细地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
        NSString *userId = [userDic objectForKey:UserLoginId];
        NSLog(@"userId:%@",userId);

        NSString *params = [NSString stringWithFormat:@"{\"cellName\":\"%@ %@\",\"detailAddress\":\"%@\",\"registeredUserId\":\"%@\"}",_quyuTF.text ,_xiaoquTF.text,_detailAddressTF.text ,userId];
        //NSString *params = [NSString stringWithFormat:@"{\"cellName\":\"%@ %@\",\"detailAddress\":\"%@\",\"registeredUserId\":\"%@\"}",[_quyuTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_xiaoquTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_detailAddressTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],userId];
        
        HomeService *homeService = [[HomeService alloc] init];
        [homeService saveServiceAddressWithParam:params andWithBlock:^(NSNumber *result, NSError *error) {
            if (!error) {
                NSLog(@"saveServiceAddressresult:%@",result);
                
                if ([result integerValue] == 0) {
                    [self.delegate AddAddressVCAddAddressQuyu:_quyuTF.text andXiaoqu:_xiaoquTF.text andDetailAddress:_detailAddressTF.text];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
               
            }
            else{
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [av show];
            }
            
        }];
        
       // [self.delegate AddAddressVCAddAddressQuyu:_quyuTF.text andXiaoqu:_xiaoquTF.text andDetailAddress:_detailAddressTF.text];
       //
    }
}

#pragma mark - quyuVC delegate
- (void)quyuVCSelectedQuyu:(NSString *)quyu{
    self.quyuTF.text = quyu;
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


@end
