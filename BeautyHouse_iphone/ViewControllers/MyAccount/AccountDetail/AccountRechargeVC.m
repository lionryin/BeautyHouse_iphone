//
//  AccountRechargeVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountRechargeVC.h"
//#import <AlipaySDK.framework/Headers/Alipay.h>
//#import <AlipaySDK/AlipaySDK.h>

//#import "DataSigner.h"
//#import "Common.h"

#import "MZBHttpService.h"

@interface AccountRechargeVC ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *flagIV1;
@property (nonatomic, strong)UIImageView *flagIV2;
@property (nonatomic, strong) UITextField *exchTF;

@end
@implementation AccountRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线充值";
    [self initMainUI];
}


- (void)initMainUI{
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    /*
    UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(10, 64+15, self.view.frame.size.width-20, 44)];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    
    
    UILabel *exchStr = [self createLabelWithFrame:CGRectMake(0, 0,120, 44)];
    exchStr.text = @" 充值金额:";
    [containView addSubview:exchStr];
    
    
    
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(10, 64+15+70, self.view.frame.size.width-20, 40)];
    [nextBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor orangeColor]];
    nextBtn.layer.cornerRadius = 4;
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];*/
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_exchTF resignFirstResponder];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 1;//2
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *reuse = @"JoinTVC";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = @"充值金额:";

        
        _exchTF = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, cell.contentView.frame.size.width-120, 44)];
        _exchTF.placeholder = @"输入想充值的金额";
        _exchTF.textAlignment =  NSTextAlignmentCenter;
        _exchTF.delegate = self;
        [cell.contentView addSubview:_exchTF];
       
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        return cell;
        
    }else{
        
        static NSString *reuse = @"PrivilegeTVC";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        switch (indexPath.row) {
            case 0:
            {
                UIImageView *aliPayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 43, 36)];
                [aliPayIV setImage:[UIImage imageNamed:@"zhifubao"]];
                [cell.contentView addSubview:aliPayIV];
                
                
                UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 100, 30)];
                name.text = @"支付宝支付";
                name.font = [UIFont systemFontOfSize:14];
                name.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:name];
                
                _flagIV1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 13, 24, 24)];
                [_flagIV1 setImage:[UIImage imageNamed:@"pay_selected"]];
                
                _flagIV1.tag = 2011;
                
                [cell.contentView addSubview:_flagIV1];
                
                
                
                
            }
                break;
                
            case 1:
            {
                UIImageView *aliPayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 43, 36)];
                [aliPayIV setImage:[UIImage imageNamed:@"weixin2"]];
                [cell.contentView addSubview:aliPayIV];
                
                
                UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 100, 30)];
                name.text = @"微信支付";
                name.font = [UIFont systemFontOfSize:14];
                name.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:name];
                
                _flagIV2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 13, 24, 24)];
                [_flagIV2 setImage:[UIImage imageNamed:@"pay_unselected"]];
                
                _flagIV2.tag = 2020;
                [cell.contentView addSubview:_flagIV2];
                
            }
                break;
                
            default:
                break;
        }
        
        
        
        
        return cell;
        
    }
    
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 44;
    }
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            _flagIV1.image = [UIImage imageNamed:@"pay_selected"];
            ;
            _flagIV1.tag = 2011;
            _flagIV2.image = [UIImage imageNamed:@"pay_unselected"];
            _flagIV2.tag = 2020;
            
        }else if (indexPath.row == 1){
            
            _flagIV1.image = [UIImage imageNamed:@"pay_unselected"];
            ;
            _flagIV1.tag = 2010;
            _flagIV2.image = [UIImage imageNamed:@"pay_selected"];
            _flagIV2.tag = 2021;
        }
        
        
        
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"信息确认";
    }else{
        return @"选择支付方式";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 60;
    }
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        
        
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [exitBtn setFrame:CGRectMake(20, 10, 280, 40)];
        [exitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [exitBtn setBackgroundColor:[UIColor orangeColor]];
        exitBtn.layer.cornerRadius = 4;
        [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:exitBtn];
        
        return view;
        
    }else{
        return nil;
    }
}


- (NSString *)getUserId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}

#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((int)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



- (void)exitAction:(id)sender{
    [self.exchTF resignFirstResponder];
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userIsLogin = [userDic objectForKey:UserIsLoginKey];
    
    if ([userIsLogin isEqualToString:@"0"]) {//未登陆
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }

    
    if (_exchTF.text.length<=0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入充值金额" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;

    }
    
    if (_flagIV1.tag == 2011) {//支付宝支付
        
        NSString *uuidString = [self generateTradeNO];//[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString *tradeId = [NSString stringWithFormat:@"%@_%@",[self getUserId],uuidString];
        
        [[MZBHttpService shareInstance] apliyPayWithOutTradeNo:tradeId andTotalFee:_exchTF.text andType:@"在线充值" callback:^(NSDictionary *resultDic) {
            
            NSString *resultStatus = resultDic [@"resultStatus"];
            if (9000 == [resultStatus intValue]) {//支付成功
                
                if ([self.delegate respondsToSelector:@selector(accountRechargeVCApliyPaySuccess)]) {
                    [self.delegate accountRechargeVCApliyPaySuccess];
                }
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
            }
        }];

        
        /*NSString *uuidString = [self generateTradeNO];//[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString *tradeId = [NSString stringWithFormat:@"%@-%@",[self getUserId],uuidString];
        
        NSString *subPayInfo = [NSString stringWithFormat:@"partner=\"2088711657481475\"&seller_id=\"meizhaikeji@sina.com\"&out_trade_no=\"%@\"&subject=\"美宅宝\"&body=\"在线充值\"&total_fee=\"%@\"&notify_url=\"http://www.mrchabo.com/order/Service/alipayNotify.do\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&return_url=\"m.alipay.com\"",tradeId,_exchTF.text];
        
        id <DataSigner> signer = CreateRSADataSigner(RSA_PRIVATE);
        NSString *signedString = [signer signString:subPayInfo];
        
        NSString *payInfo = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",subPayInfo,signedString,@"RSA"];
        
        [[AlipaySDK defaultService] payOrder:payInfo fromScheme:@"" callback:^(NSDictionary *resultDic) {
            NSLog(@"%@",resultDic);
            //NSDictionary *jsonQuery=[self dictFromString:resultStr];
            NSString *resultStatus = resultDic [@"resultStatus"];
            if (9000 == [resultStatus intValue]) {//支付成功
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
            }
            
        }];*/
        

        
       /* Alipay *pay = [Alipay defaultService];
        
        [pay pay:payInfo from:@"" callback:^(NSString *resultStr) {
            
            NSDictionary *jsonQuery=[self dictFromString:resultStr];
            NSString *resultStatus = jsonQuery [@"ResultStatus"];
            if (9000 == [resultStatus intValue]) {//支付成功
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                
            }
            
        }];*/
        
        
        
    }else if (_flagIV2.tag == 2021){//微信支付
        
    }
    else{
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择一种支付方式" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UILabel *)createLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
#pragma mark - UItextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
