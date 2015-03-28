//
//  LoginVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "LoginVC.h"
#import "MZBWebService.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UITextField *codeTextField;
@property (nonatomic,strong)UIButton *getCodeBtn;
@property (nonatomic,strong)UIButton *loginBtn;


@end

@implementation LoginVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"快速登录";
    
    [self initUI];
    
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
    
    
    self.phoneTextField = [self createTextFieldWithFrame:CGRectMake(10, 60, 160, 50)];
    
    self.phoneTextField.placeholder = @"手机号";
    
    [self.scrollView addSubview:self.phoneTextField];
    
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setFrame:CGRectMake(180, 60, 120, 50)];
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.getCodeBtn];
    
    
    self.phoneTextField = [self createTextFieldWithFrame:CGRectMake(10, 120, 300, 50)];
    self.phoneTextField.placeholder = @"验证码";
    
    [self.scrollView addSubview:self.phoneTextField];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(20, 190, 280, 50)];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.loginBtn];
    
    
}


- (NSString *)getUserPhoneNumber{
    NSString *phoneStr = nil;
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    phoneStr = [accountDefaults objectForKey:UserPhoneNumberKey];
    
    return phoneStr;
}


- (void)getCodeAction:(id)sender{
    
}

- (void)loginAction:(id)sender{
    
}

- (UITextField *)createTextFieldWithFrame:(CGRect)frame{
    
    UITextField *textfield=[[UITextField alloc]initWithFrame:frame];
    textfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textfield.borderStyle=UITextBorderStyleRoundedRect;
    textfield.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    textfield.delegate=self;
    
    return textfield;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    return YES;
}

@end
