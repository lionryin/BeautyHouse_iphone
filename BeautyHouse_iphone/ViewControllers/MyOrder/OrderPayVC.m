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

@interface OrderPayVC ()<UITextFieldDelegate>
- (IBAction)payButtonSelecked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"订单支付";
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
            NSString *subPayInfo = @"partner=\"2088711657481475\"&seller_id=\"meizhaikeji@sina.com\"&subject=\"美宅宝\"&body=\"订单支付\"&notify_url=\"http://www.mrchabo.com/order/Service/alipayNotify.do\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&return_url=\"m.alipay.com\"&sign=\"M57EIluNFAusE%2BiI31iPZqlAAxVWthl0Cvg0Y9I5wEt0HUaUFkQgUIHWYeLLn2HLfa9oKo6adgq4AUZ2lSjvjTeqbryqB3zwKJcMDRtk%2F%2BQtv7Y3ymm8hmbFR3Ka14PitREsJmDPP3t%2Bc9Z%2FQv6PgQwZoYXJw6sX%2BB%2FtdpnwV3I%3D\"&sign_type=\"RSA\"";
            
            
            NSString *payInfo = [NSString stringWithFormat:@"total_fee=\"%@\"&out_trade_no=\"%@\"&%@",self.rmbTF.text,self.orderVO.orderID,subPayInfo];
            
            
            Alipay *pay = [Alipay defaultService];
            
            [pay pay:payInfo from:@"" callback:^(NSString *resultStr) {
                
                NSDictionary *jsonQuery=[self dictFromString:resultStr];
                NSString *resultStatus = jsonQuery [@"ResultStatus"];
                if (9000 == [resultStatus intValue]) {//支付成功
                    
                    
                    
                }else{
                    
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
                NSLog(@"html:%@",html);
                

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"发生错误！%@",error);
            }];
            [operation start];
            
            
            
            
        }
        else if (_imageView3.highlighted){//微信支付
            
        }
        else if (_imageView4.highlighted){//余额支付
            
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

@end
