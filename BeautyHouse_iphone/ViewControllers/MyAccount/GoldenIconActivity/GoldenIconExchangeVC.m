//
//  GoldenIconExchangeVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "GoldenIconExchangeVC.h"
#import "MZBWebService.h"

@interface GoldenIconExchangeVC ()
@property (nonatomic, strong) UILabel *balanceValue;
@property (nonatomic, strong) UITextField *exchTF;
@end
@implementation GoldenIconExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换";
    [self initMainUI];
}

- (void)initMainUI{
    UILabel *tipsLabel = [self createLabelWithFrame:CGRectMake(10, 64+10, self.view.frame.size.width-20, 30)];
    tipsLabel.text = @"金币策略:100金币 = 1元";
    [self.view addSubview:tipsLabel];
    
    
    UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(10, 64+50, tipsLabel.frame.size.width, 88)];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    UILabel *balanceStr = [self createLabelWithFrame:CGRectMake(10, 7, 100, 30)];
    balanceStr.text = @"金币余额:";
    [containView addSubview:balanceStr];
    
    _balanceValue = [self createLabelWithFrame:CGRectMake(110, 7, containView.frame.size.width-120, 30)];
    _balanceValue.text = [NSString stringWithFormat:@"%li",self.balance];
    _balanceValue.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:_balanceValue];
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(0, 43, containView.frame.size.width, 1)];
    hLine.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
    [containView addSubview:hLine];
    
    UILabel *exchStr = [self createLabelWithFrame:CGRectMake(10, 44+7, 100, 30)];
    exchStr.text = @"金币数:";
    [containView addSubview:exchStr];
    
    
    _exchTF = [[UITextField alloc]initWithFrame:CGRectMake(110, 44+7, containView.frame.size.width-120, 30)];
    _exchTF.placeholder = @"输入想兑换的金币数";
    _exchTF.textAlignment =  NSTextAlignmentCenter;
    _exchTF.keyboardType = UIKeyboardTypeNumberPad;
    [containView addSubview:_exchTF];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(10, 64+150, self.view.frame.size.width-20, 40)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor orangeColor]];
    nextBtn.layer.cornerRadius = 4;
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
    
}



- (NSString *)getUserLoginId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}



- (void)nextBtnAction:(id)sender{
    
    NSInteger exchCoins = [self.exchTF.text integerValue];
    if (exchCoins<=0) {
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请想兑换的金币数" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        
        return;
    }
    
    
    if ([self getUserLoginId]) {
        NSString *jsonParam = [NSString stringWithFormat:@"{\"registeredUserId\":\"%@\",\"number\":\"%li\",\"sign\":\"1\"}",[self getUserLoginId],exchCoins];
        AFHTTPRequestOperation *opration = [MZBWebService goldCoinsExchangeWithParameter:jsonParam];
        
        [opration start];
        
        [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
            NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            
            MyPaser *parser = [[MyPaser alloc] initWithContent:result];
            [parser BeginToParse];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            NSNumber *rst = dic[@"result"];
            if (rst.integerValue == 0) {
                
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜,兑换成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [av show];
                
                
            }else{
                
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [av show];
                
            }
            
            
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
        }];
        
    }else{
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请返回个人中心登录" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
    }

    
}


- (UILabel *)createLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    return label;
}


@end
