//
//  OrderPayVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderPayVC.h"

#import "MZBWebService.h"
#import <AlipaySDK.framework/Headers/Alipay.h>

#import "HomeService.h"
#import "OrderPaySuccessVC.h"


#import "Constant.h"
//#import <MBProgressHUD/MBProgressHUD.h>
#import "WXPayClient.h"

#import "DataSigner.h"
#import "Common.h"


@interface OrderPayVC ()<UITextFieldDelegate,OrderPaySuccessDelegate,UIAlertViewDelegate>
- (IBAction)payButtonSelecked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property (nonatomic) double yue;

@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"订单支付";
    _yue = 0;
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    NSLog(@"orderid:%@",_orderVO.orderID);
    
    HomeService *homeService = [[HomeService alloc] init];
    [homeService balanceOfUserQueriesWithParam:[NSString stringWithFormat:@"{\"id\":\"%@\"}",userId] andWithBlock:^(NSNumber *result, NSNumber *resultInfo, NSError *error) {
        
        if (!error) {
            if ([result integerValue] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _yueLabel.text = [NSString stringWithFormat:@"余额%.2f",[resultInfo doubleValue]];
                    _yue = [resultInfo doubleValue];
                });
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"获取余额失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }

        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)payButtonSelecked:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 1:{//支付宝
            _imageView1.highlighted = !_imageView1.highlighted;
            _imageView2.highlighted = NO;
            _imageView3.highlighted = NO;
            _imageView4.highlighted = NO;
            
            break;
        }
        case 2:{//现金
            
            _imageView2.highlighted = !_imageView2.highlighted;
            _imageView1.highlighted = NO;
            _imageView3.highlighted = NO;
            _imageView4.highlighted = NO;
            
            break;
        }
        case 3:{//微信
            
            _imageView3.highlighted = !_imageView3.highlighted;
            _imageView2.highlighted = NO;
            _imageView1.highlighted = NO;
            _imageView4.highlighted = NO;
            
            break;
        }
        case 4:{//余额
            
            _imageView4.highlighted = !_imageView4.highlighted;
            _imageView2.highlighted = NO;
            _imageView3.highlighted = NO;
            _imageView1.highlighted = NO;
            
            break;
        }
        default:
            break;
    }
}

- (IBAction)nextStepButtonPressed:(id)sender {
    if (_rmbTF.text.length <= 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付金额不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    else {
        if (_imageView1.highlighted) {//支付宝支付
            
            NSString *subPayInfo = [NSString stringWithFormat:@"partner=\"2088711657481475\"&seller_id=\"meizhaikeji@sina.com\"&out_trade_no=\"%@\"&subject=\"美宅宝\"&body=\"订单支付\"&total_fee=\"%@\"&notify_url=\"http://www.mrchabo.com/order/Service/alipayNotify.do\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&return_url=\"m.alipay.com\"",self.orderVO.orderID,self.rmbTF.text];
            
            id <DataSigner> signer = CreateRSADataSigner(RSA_PRIVATE);
            NSString *signedString = [signer signString:subPayInfo];
            
            NSString *payInfo = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",subPayInfo,signedString,@"RSA"];
            
            
            Alipay *pay = [Alipay defaultService];
            
            [pay pay:payInfo from:@"" callback:^(NSString *resultStr) {
                
                NSDictionary *jsonQuery=[self dictFromString:resultStr];
                NSString *resultStatus = jsonQuery [@"ResultStatus"];
                if (9000 == [resultStatus intValue]) {//支付成功
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    alert.tag = 102;
                    [alert show];

                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败，发生未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }];
            
        }
        else if (_imageView2.highlighted){//现金支付
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mrchabo.com/order/Service/offlinePay.do?id=%@&deductions=%@",_orderVO.orderID,_rmbTF.text]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            //
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *html = operation.responseString;
                //NSLog(@"html:%@",html);
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"%@",dic);
                
                if ([[dic objectForKey:@"result"] integerValue] == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        OrderPaySuccessVC *paySuccessVC = [[OrderPaySuccessVC alloc] initWithNibName:@"OrderPaySuccessVC" bundle:nil];
                        paySuccessVC.delegate = self;
                        [self.navigationController pushViewController:paySuccessVC animated:YES];
                    });
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];

                }
                

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"发生错误！%@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];

            }];
            [operation start];
            
            
            
            
        }
        else if (_imageView3.highlighted){//微信支付
            
            //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:HUDDismissNotification object:nil];
            
            [[WXPayClient shareInstance] payProduct];
            
        }
        else if (_imageView4.highlighted){//余额支付
            
            if (_yue < [_rmbTF.text doubleValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"余额不足" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
                
                return;
            }
            
            NSString *param = [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":null,\"memo\":null,\"deductions\":%@,\"houseSize\":null,\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":\"%@\",\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":null,\"registeredUserId\":null,\"serviceCategory\":null,\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":null}",_rmbTF.text,_orderVO.orderID];
            HomeService *homeService = [[HomeService alloc] init];
            [homeService balancesPayWithParam:param andWithBlock:^(NSNumber *result, NSError *error) {
                if (!error) {
                    if ([result integerValue] == 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        alert.tag = 101;
                        [alert show];
                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败，发生未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }];
            
        }
        else{
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择一种支付方式" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [av show];
            return;
        }
    }
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - OrderPaySuccessVC delegate
- (void)orderPaySuccessVCLeftButtonClicked{
    if ([self.delegate respondsToSelector:@selector(orderPayVCPaySuccess)]) {
        [self.delegate orderPayVCPaySuccess];
    }
}

- (NSDictionary *)dictFromString:(NSString *)aString
{
    NSData *theData = [aString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSError *error = nil;
    
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:theData options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"error convert json string to dict,%@,%@", aString, error);
        return nil;
    }
    else {
        return resultDict;
    }
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101 || alertView.tag == 102) {
        if ([self.delegate respondsToSelector:@selector(orderPayVCPaySuccess)]) {
            [self.delegate orderPayVCPaySuccess];
        }

        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
