//
//  AccountFamilyStewardVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountFamilyStewardVC.h"
#import "MZBWebService.h"


@interface AccountFamilyStewardVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *birthdayTF;

@property (nonatomic, strong) UIButton *boyBtn;
@property (nonatomic, strong) UIButton *girlBtn;

@end


@implementation AccountFamilyStewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭管家";
    [self initMainUI];
}

- (void)initMainUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

- (NSString *)getUserPhone{
    NSString *userPhone = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userPhone = [userDic objectForKey:UserPhoneNumberKey];
    
    return userPhone;
}


- (NSString *)getUserId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}

- (void)boyBtnClicked:(UIButton *)sender{
    if (sender.selected) {
        return;
    }else{
        sender.selected = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"selected_Address"] forState:UIControlStateNormal];
        [self.girlBtn setBackgroundImage:[UIImage imageNamed:@"unselected_Address"] forState:UIControlStateNormal];
        self.girlBtn.selected = NO;
    }
}

- (void)girlBtnClicked:(UIButton *)sender{
    if (sender.selected) {
        return;
    }else{
        sender.selected = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"selected_Address"] forState:UIControlStateNormal];
        [self.boyBtn setBackgroundImage:[UIImage imageNamed:@"unselected_Address"] forState:UIControlStateNormal];
        self.boyBtn.selected = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    switch (indexPath.row) {
        case 0:{
            UILabel *str = [self createLabelWithFrame:CGRectMake(0, 0, 95, 44)];
            str.textAlignment = NSTextAlignmentRight;
            str.text = @"注册账号";
            [cell.contentView addSubview:str];
            
            UIView  *vline = [[UIView alloc]initWithFrame:CGRectMake(103, 10, 1, 24)];
            vline.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:vline];
            
            self.phoneTF = [self createTextFieldWithFrame:CGRectMake(110, 0, 200, 44)];
            self.phoneTF.placeholder = [self getUserPhone];
            [cell.contentView addSubview:self.phoneTF];
            
        }
            
            break;
            
        case 1:{
            
            UILabel *str = [self createLabelWithFrame:CGRectMake(0, 0, 95, 44)];
            str.text = @"用户名";
            [cell.contentView addSubview:str];
            
            UIView  *vline = [[UIView alloc]initWithFrame:CGRectMake(103, 10, 1, 24)];
            vline.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:vline];
            
            self.nameTF = [self createTextFieldWithFrame:CGRectMake(110, 0, 200, 44)];
            //self.phoneTF.placeholder = ;
            [cell.contentView addSubview:self.nameTF];
            
        }
            
            break;
            
            
        case 2:{
            
            UILabel *str = [self createLabelWithFrame:CGRectMake(0, 0, 95, 64)];
            str.text = @"性别";
            [cell.contentView addSubview:str];
            
            UIView  *vline = [[UIView alloc]initWithFrame:CGRectMake(103, 10, 1, 44)];
            vline.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:vline];
            
            self.boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.boyBtn setFrame:CGRectMake(120, 20, 24, 24)];
            [self.boyBtn setBackgroundImage:[UIImage imageNamed:@"selected_address"] forState:UIControlStateNormal];
            [self.boyBtn addTarget:self action:@selector(boyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.boyBtn.selected = YES;
            [cell.contentView addSubview:self.boyBtn];
            
            UILabel *strboy = [self createLabelWithFrame:CGRectMake(150, 20, 16, 24)];
            strboy.text = @"男";
            [cell.contentView addSubview:strboy];
            
            
            self.girlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.girlBtn setFrame:CGRectMake(200, 20, 24, 24)];
            [self.girlBtn setBackgroundImage:[UIImage imageNamed:@"unselected_address"] forState:UIControlStateNormal];
            self.girlBtn.selected = NO;
            [self.girlBtn addTarget:self action:@selector(girlBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:self.girlBtn];
            
            UILabel *strgirl = [self createLabelWithFrame:CGRectMake(230, 20, 16, 24)];
            strgirl.text = @"女";
            [cell.contentView addSubview:strgirl];
            
            
            
        }
            
            break;
            
            
        case 3:{
            
            UILabel *str = [self createLabelWithFrame:CGRectMake(0, 0, 95, 44)];
            str.text = @"出生年月";
            [cell.contentView addSubview:str];
            
            UIView  *vline = [[UIView alloc]initWithFrame:CGRectMake(103, 10, 1, 24)];
            vline.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:vline];
            
            self.birthdayTF = [self createTextFieldWithFrame:CGRectMake(110, 0, 200, 44)];
            //self.phoneTF.placeholder = ;
            [cell.contentView addSubview:self.birthdayTF];
            
        }
            
            break;
            
        default:
            break;
    }
    
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setFrame:CGRectMake(20, 10, 280, 40)];
    [exitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitBtn setBackgroundColor:[UIColor orangeColor]];
    exitBtn.layer.cornerRadius = 4;
    [exitBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:exitBtn];
    
    return footer;
}


- (void)saveAction:(id)sender{
    
    if ([self getUserId]) {
        NSString *jsonParam = [NSString stringWithFormat:@"{\"id\":\"%@\",\"phone\":\"%@\",\"userName\":\"%@\",\"birthday\":\"%@\"}",[self getUserId],[self getUserPhone],[self.nameTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.birthdayTF.text];
        AFHTTPRequestOperation *opration = [MZBWebService getUserBalanceWithParameter:jsonParam];
        
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
                
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存信息成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [av show];
            
                
            }
            
            
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
        }];
        
    }else{
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请返回个人中心登录" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 64;
    }else{
        return 44;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.phoneTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
    [self.birthdayTF resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.birthdayTF) {
        [self.tableView setContentOffset:CGPointMake(0, 40) animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UILabel *)createLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (UITextField *)createTextFieldWithFrame:(CGRect)frame{
    
    UITextField *textfield=[[UITextField alloc]initWithFrame:frame];
    textfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    //textfield.borderStyle=UITextBorderStyleRoundedRect;
    textfield.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    textfield.delegate=self;
    
    return textfield;
}

@end
