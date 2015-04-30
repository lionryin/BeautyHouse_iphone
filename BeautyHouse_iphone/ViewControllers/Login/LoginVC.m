//
//  LoginVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "LoginVC.h"
#import "CountdownButton.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UITextField *codeTextField;
@property (nonatomic,strong)CountdownButton *getCodeBtn;
@property (nonatomic,strong)UIButton *loginBtn;


@end

@implementation LoginVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initTitleBar];

    [self initUI];
    
}

- (void)initTitleBar{
    self.title = @"快速登录";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, 20)];
    //        [btn setTitle:@"哈哈" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.alwaysBounceVertical=YES;
    [self.view addSubview:self.scrollView];
    
    
    UILabel *tipsLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 40)];
    tipsLabel.backgroundColor =[UIColor clearColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = [UIFont systemFontOfSize:15];
    tipsLabel.textColor = [UIColor darkGrayColor];
    tipsLabel.text = @"为了确保服务质量,请先验证您的手机";
    [self.scrollView addSubview:tipsLabel];
    
    
    self.phoneTextField = [self createTextFieldWithFrame:CGRectMake(10, 60, 160, 40)];
    self.phoneTextField.placeholder = @"手机号";
    
    NSString *phone = [self getUserPhoneNumber];
    if (phone.length>1) {
        self.phoneTextField.text = phone;
    }
    
    
    [self.scrollView addSubview:self.phoneTextField];
    
    
    self.getCodeBtn = [[CountdownButton alloc]initWithFrame:CGRectMake(180, 60, 120, 40) time:60 normalTitle:@"获取验证码" countingTitle:@"重新获取"];
//    [self.getCodeBtn setFrame:CGRectMake(180, 60, 120, 40)];
//    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.getCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.getCodeBtn.layer.cornerRadius = 4;
    self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.getCodeBtn];
    
    
    self.codeTextField = [self createTextFieldWithFrame:CGRectMake(10, 110, 300, 40)];
    self.codeTextField.placeholder = @"验证码";
    
    [self.scrollView addSubview:self.codeTextField];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(20, 170, 280, 40)];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor orangeColor]];
    self.loginBtn.layer.cornerRadius = 4;
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.loginBtn];
    
    
}


- (NSString *)getUserPhoneNumber{
    NSString *phoneStr = nil;

    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    phoneStr = [userDic objectForKey:UserPhoneNumberKey];
    
    return phoneStr;
}


- (void)getCodeAction:(id)sender{
    
    if (self.phoneTextField.text.length<=0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];

        [av show];
        return;
        
    }else if (self.phoneTextField.text.length<11 || self.phoneTextField.text.length>11) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入11位手机号" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        return;
        
    }else{
        
        if (![self.phoneTextField.text hasPrefix:@"1"]) {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码必须以1开头" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [av show];
                return;
        }else{
            
            [self.getCodeBtn startCounting];
            
            NSString *jsonParam = [NSString stringWithFormat:@"{\"phone\":\"%@\"}",self.phoneTextField.text];
            AFHTTPRequestOperation *opration = [MZBWebService getPhoneVerifyCode:jsonParam];
            
            [opration start];
            
            [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
                NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"%@",result);
                
                MyPaser *parser = [[MyPaser alloc] initWithContent:result];
                [parser BeginToParse];
                
                //NSLog(@"%@",parser.result);
                
        
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"%@",dic);
                NSNumber *rst = dic[@"result"];
                if (rst.integerValue == 0) {
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"resultInfo"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    
                    [av show];
                }
                
                

                
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                
                
            }];
            
            
            
        }
        
        
    }
    
    
    
    
    
}

- (void)loginAction:(id)sender{
    if (!self.codeTextField.text>0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        return;
        
    }else{
        
        NSString *jsonParam = [NSString stringWithFormat:@"{\"phone\":\"%@\",\"code\":%@}",self.phoneTextField.text,self.codeTextField.text];
        AFHTTPRequestOperation *opration = [MZBWebService login:jsonParam];
        
        [opration start];
        
        [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
            NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",result);
            
            MyPaser *parser = [[MyPaser alloc] initWithContent:result];
            [parser BeginToParse];
            
            //NSLog(@"%@",parser.result);
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            
            NSNumber *loginOK = dic[@"result"];
            if (loginOK.integerValue == 0) {
                
                NSDictionary *resultInfo = dic[@"resultInfo"];
                
                NSString *userId = resultInfo[@"id"];
                
                NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *userDic = [accountDefaults dictionaryForKey:UserGlobalKey];
                NSMutableDictionary *mUserDic= [userDic mutableCopy];
                
                [mUserDic setObject:@"1" forKey:UserIsLoginKey];
                [mUserDic setObject:self.phoneTextField.text forKey:UserPhoneNumberKey];
                [mUserDic setObject:userId forKey:UserLoginId];
                
                [accountDefaults setObject:mUserDic forKey:UserGlobalKey];
                
                [accountDefaults synchronize];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    if (_isOrderFrom) {
                        UIWindow * window = [UIApplication sharedApplication].keyWindow ;
                        ((UITabBarController *)window.rootViewController).selectedIndex = 1;
                    }
                }];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:MZB_NOTE_LOGIN_OK object:nil];
                
                
            }else{
                
                
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"failInfo"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [av show];
                
            }
            
            
            
            
            
            
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
        }];
        
        
    }
    
    
}

- (UITextField *)createTextFieldWithFrame:(CGRect)frame{
    
    UITextField *textfield=[[UITextField alloc]initWithFrame:frame];
    textfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textfield.borderStyle=UITextBorderStyleRoundedRect;
    textfield.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //textfield.ac
    textfield.delegate=self;
    
    return textfield;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    return YES;
}

@end
