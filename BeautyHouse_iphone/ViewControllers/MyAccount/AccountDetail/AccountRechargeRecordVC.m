//
//  AccountRechargeRecordVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountRechargeRecordVC.h"
#import "AccountExpenseRecordTVC.h"
#import "MZBWebService.h"

@interface AccountRechargeRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;

@end
@implementation AccountRechargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    [self initMainUI];
    [self getExpenseRecord];
}

- (void)initMainUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

- (NSString *)getUserId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}


- (void)getExpenseRecord{
    
    NSString *param = [NSString stringWithFormat:@"{\"memberId\":\"%@\",\"sign\":1}",[self getUserId]];
    
    AFHTTPRequestOperation *opration = [MZBWebService getListRechargeInfoWithParameter:param];
    
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
            
            NSArray *list = dic[@"resultInfo"];
            
            self.list = list;
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserIdentifier = @"Cell";
    AccountExpenseRecordTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (cell == nil) {
        cell = [[AccountExpenseRecordTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
        
    }
    
    //[cell updateCellWithDictionary:self.list[indexPath.row]];
    cell.resultInfo = self.list[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"充值记录";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

@end
